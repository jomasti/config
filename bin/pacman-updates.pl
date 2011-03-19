#!/usr/bin/perl
use strict;
use warnings;
print (`pacman -Qu | wc -l`);
