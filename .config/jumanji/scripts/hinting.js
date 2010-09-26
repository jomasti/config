// HINTSTYLE: letter || number or whatever you want
var HINTSTYLE = "letter";
var elements = [];
var active_arr = [];
var hints;
var overlays;
var active;
var lastpos = 0;

focus_color = "#00ff00";
normal_color = "#ffff99";
opacity = 0.3;
border = "1px dotted #000000";

hint_foreground = "#ffffff";
hint_background = "#0000aa";
hint_border = "2px dashed #000000";
hint_opacity = 0.6;
hint_font_size =  "12px";
hint_font_weight = "bold";
hint_font_family = "monospace";

vertical_offset = 0;
horizontal_offset = -10;
var letters_seq = "fdsartgbvecwxqyiopmnhzulkj"

// Hint
function Hint(element) {
  this.element = element;
  this.rect = element.getBoundingClientRect();

  function create_span(element, h, v) {
    var span = document.createElement("span");
    var leftpos = Math.max((element.rect.left + document.defaultView.scrollX), document.defaultView.scrollX) + h;
    var toppos = Math.max((element.rect.top + document.defaultView.scrollY), document.defaultView.scrollY) + v;
    span.style.position = "absolute";
    span.style.left = leftpos + "px";
    span.style.top = toppos + "px";
    return span;
  }
  function create_hint(element) {
    var hint = create_span(element, horizontal_offset, vertical_offset - element.rect.height/2);
    hint.style.fontSize = hint_font_size;
    hint.style.fontWeight = hint_font_weight;
    hint.style.fontFamily = hint_font_family;
    hint.style.color = hint_foreground;
    hint.style.background = hint_background;
    hint.style.opacity = hint_opacity;
    hint.style.border = hint_border;
    hint.style.zIndex = 10001;
    hint.style.visibility = 'visible';
    return hint;
  }
  function create_overlay(element) {
    var overlay = create_span(element, 0, 0);
    overlay.style.width = element.rect.width + "px";
    overlay.style.height = element.rect.height + "px";
    overlay.style.opacity = opacity;
    overlay.style.backgroundColor = normal_color;
    overlay.style.border = border;
    overlay.style.zIndex = 10000;
    overlay.style.visibility = 'visible';
    overlay.addEventListener( 'click', function() { click_element(element); }, false );
    return overlay;
  }

  this.hint = create_hint(this);
  this.overlay = create_overlay(this);
}
//NumberHint
NumberHint.prototype.getTextHint = function (i, length) {
  start = length <=10 ? 1 : length <= 100 ? 10 : 100;
  var content = document.createTextNode(start + i);
  this.hint.appendChild(content);
}
NumberHint.prototype.betterMatch = function(input) {
  var bestposition = 37;
  var ret = 0;
  for (var i=0; i<active_arr.length; i++) {
    var e = active_arr[i];
    if (input && bestposition != 0) {
      var content = e.element.textContent.toLowerCase().split(" ");
      for (var cl=0; cl<content.length; cl++) {
        if (content[cl].toLowerCase().indexOf(input) == 0) {
          if (cl < bestposition) {
            ret = i;
            bestposition = cl;
            break;
          }
        }
      }
    }
  }
  return ret;
}
NumberHint.prototype.matchText = function(input) {
  var ret = false;
  if (parseInt(input) == input) {
    text_content = this.hint.textContent;
  }
  else {
    text_content = this.element.textContent.toLowerCase();
  }
  if (text_content.match(input)) {
    return true;
  }
}

// LetterHint
LetterHint.prototype.getTextHint = function(i, length) {
  var text;
  if (length < 26) {
    text = letters_seq[i];
  }
  else {
    text = letters_seq[parseInt(i/26)] + letters_seq[25-(i%26)];
  }
  var content = document.createTextNode(text);
  this.hint.appendChild(content);
}

LetterHint.prototype.betterMatch = function(input) {
  for (var i=0; i<active_arr.length; i++) {
    var e = active_arr[i];
    if (e.hint.textContent.indexOf(input.toLowerCase()) == 0) {
      return i;
    }
  }
}

LetterHint.prototype.matchText = function(input) {
  return this.hint.textContent.match(input.toLowerCase());
}


function LetterHint(element) {
  this.constructor = Hint;
  this.constructor(element);
}
LetterHint.prototype = new Hint();

function NumberHint(element) {
  this.constructor = Hint;
  this.constructor(element);
}
NumberHint.prototype = new Hint();


function show_hints() {
  document.activeElement.blur();
  var res = document.body.querySelectorAll('a, area, textarea, select, link, input:not([type=hidden]), button,  frame, iframe');
  hints = document.createElement("div");
  overlays  = document.createElement("div");
  for (var i=0; i<res.length; i++) {
    var e = HINTSTYLE.toLowerCase() == "letter" ? new LetterHint(res[i]) : new NumberHint(res[i]);
    hints.appendChild(e.hint);
    var rects = e.element.getClientRects()[0];
    var r = e.rect;
    if (!r || r.top > window.innerHeight || r.bottom < 0 || r.left > window.innerWidth ||  r < 0 || !rects ) {
      continue;
    }
    var style = document.defaultView.getComputedStyle(e.element, null);
    if (style.getPropertyValue("visibility") != "visible" || style.getPropertyValue("display") == "none") {
      continue;
    }
    elements.push(e);
  };
  elements.sort( function(a,b) { return a.rect.top - b.rect.top; });
  for (var i=0; i<elements.length; i++) {
    var e = elements[i];
    e.getTextHint(i, elements.length);
    overlays.appendChild(e.overlay);
  }
  elements[0].overlay.style.backgroundColor = focus_color;
  active_arr = elements;
  document.body.appendChild(hints);
  document.body.appendChild(overlays);
}
function is_input(element) {
  var e = element.element;
  var type = e.type.toLowerCase();
  if (e.tagName == "INPUT" || e.tagName == "TEXTAREA" ) {
    if (type == "radio" || type == "checkbox") {
      e.checked = !e.checked;
    }
    else if (type == "submit" || type == "reset" || type  == "button") {
      click_element(element);
    }
    else {
      e.focus();
    }
    return true;
  }
  return false;
}
function update_hints(input) {
  var array = [];
  if (input) {
    input = input.toLowerCase();
  }
  for (var i=0; i<active_arr.length; i++) {
    var e = active_arr[i];
    if (e.matchText(input)) {
      array.push(e);
    }
    else {
      e.hint.style.visibility = 'hidden';
      e.overlay.style.visibility = 'hidden';
    }
  }
  active_arr = array;
  if (array.length == 0) {
    clear();
    return;
  }
  else if (array.length == 1) {
    return  evaluate(array[0]);
  }
  else {
    array[lastpos].overlay.style.backgroundColor = normal_color;
    lastpos = array[0].betterMatch(input);
    array[lastpos].overlay.style.backgroundColor = focus_color;
  }
}
function clear() {
  if (overlays.parentNode) {
    overlays.parentNode.removeChild(overlays);
  }
  if (hints.parentNode) {
    hints.parentNode.removeChild(hints);
  }
  elements = [];
  active_arr = [];
  active = undefined;
}
function evaluate(element) {
  var ret;
  var e = element.element;
  if (!is_input (element) && e.href) {
    if (e.href.match(/javascript:/) || (e.type.toLowerCase() == "button")) {
      click_element(element);
    }
    else {
      ret = e.href;
    }
  }
  clear();
  return ret;
}

function click_element(e) {
  var mouseEvent = document.createEvent("MouseEvent");
  mouseEvent.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
  e.element.dispatchEvent(mouseEvent);
  clear();
}

function get_active() {
  return evaluate(active);
}

function focus(newpos) {
  active_arr[lastpos].overlay.style.backgroundColor = normal_color;
  active_arr[newpos].overlay.style.backgroundColor = focus_color;
  active = active_arr[newpos];
  lastpos = newpos;
}
function focus_next() {
  var newpos = lastpos == active_arr.length-1 ? 0 : lastpos + 1;
  focus(newpos);
}
function focus_prev() {
  var newpos = lastpos == 0 ? active_arr.length-1 : lastpos - 1;
  focus(newpos);
}
