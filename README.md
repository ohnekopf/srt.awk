# srt.awk

usage:
`$ awk -f srt.awk -v shift=<+-shift in seconds> infile.srt > outfile.srt `
`$ awk -f srt.awk -v shift=45.675 infile.srt > outfile.srt `
positive values for `shift` make subs appear later, negative values make them appear sooner


srt.awk - lightweight awk script to shift timestamps in  .srt sub files
Copyright (C) 2021  ohnekopf

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

