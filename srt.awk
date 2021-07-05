#!/usr/bin/awk -f

# srt.awk - lightweight awk script to shift timestamps in  .srt sub files
# Copyright (C) 2021  ohnekopf
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

function usage()
{
	print "usage: " ARGV[0] " -f srt.awk -v shift=<+-shift in seconds> infile.srt > outfile.srt"  
	print "for example: \n" ARGV[0] " -f srt.awk -v shift=45.675 infile.srt > outfile.srt "  
	print "positive values for 'shift' make subs appear later, negative values make them appear sooner"
}

function ts_shift(ts)
{
   	split(ts,hms,":");
	h = hms[1]; m = hms[2];  s = hms[3]; 
	sub(/,/,".",s);

	s += shift;
	# watch out for negative modulus
	ns = (s%60 + 60)%60;
	# might get floating point trouble here

	s -= ns;
	s /= 60;

	carry = int(s + 0.1 * s % 1) ; # floating point silliness

	# floating point silliness is over now

	m+=carry;
	nm = (m%60 + 60)%60;

	carry = int((m-nm)/60);
	h+= carry;

	#what happens when h is negative? you are f'd I guess

	ans = sprintf("%02d:%02d:%06.3f",h,nm,ns);

	sub(/\./,",",ans);

	return ans;
}

BEGIN {
	if (shift !~ /^[+-]?[0-9]+(\.[0-9]*)?$/ ) { usage() ; exit;} 
}

# change lines with timestamps
/^-?[0-9:,]+ -->/ {	print ts_shift($1) " --> " ts_shift($3); }
# and just let pass those without
! /^-?[0-9:,]+ -->/ { print; }

