<#

.SYNOPSIS
Makes a song file using PowerShell.

.DESCRIPTION
Demonstrates using the console beep feature to play music.

Right-click this script and select the "Run with PowerShell" menu item.

Please consider giving to cancer research this holiday season.

.PARAMETER script
Writes an optimized PowerShell script of console beeps to the output stream.

.INPUTS
None.

.OUTPUTS
A collection of notes used to play the song.

.EXAMPLE
.\Make-Song.ps1
Starts the program for playing only.
The tempo plays slower on some platforms due to the function calls.

.EXAMPLE
.\Make-Song.ps1 -script > Play-MySong.ps1
Redirects a set of optimized console beeps into a new PowerShell script.
The output stream contains the raw frequency and duration values.

.NOTES
MIT License

Copyright (c) 2022 TigerPointe Software, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

If you enjoy this software, please do something kind for free.

History:
01.00 2022-Dec-03 Scott S. Initial release.
01.01 2022-Dec-04 Scott S. Added an optimized output script feature.

.LINK
https://devblogs.microsoft.com/scripting/powertip-use-powershell-to-send-beep-to-console/

.LINK
https://pages.mtu.edu/~suits/notefreqs.html

.LINK
https://braintumor.org/

.LINK
https://www.cancer.org/

#>

# define the script switch parameter
param
(
  [switch]$script
)

# note frequencies for a three-octave range
# columns start with C3, C4 (middle C), C5
# see https://pages.mtu.edu/~suits/notefreqs.html
$notes = @{
  "C"  = @(130.81, 261.63, 523.25)
  "C#" = @(138.59, 277.18, 554.37)
  "D"  = @(146.83, 293.66, 587.33)
  "D#" = @(155.56, 311.13, 622.25)
  "E"  = @(164.81, 329.63, 659.25)
  "F"  = @(174.61, 349.23, 698.46)
  "F#" = @(185.00, 369.99, 739.99)
  "G"  = @(196.00, 392.00, 783.88)
  "G#" = @(207.65, 415.30, 830.61)
  "A"  = @(220.00, 440.00, 880.00)
  "A#" = @(233.08, 466.16, 932.33)
  "B"  = @(246.94, 493.88, 987.77)
}

# hold for whole, half, quarter, eighth and sixteenth notes (in milliseconds)
$tempo = 2800;
$holds = @{
  "W" = $tempo
  "H" = [Math]::Round($tempo / 2)
  "Q" = [Math]::Round($tempo / 4)
  "E" = [Math]::Round($tempo / 8)
  "S" = [Math]::Round($tempo / 16)
}

# plays the specified note signature
function Play-Note {
  param
  (
      [int]$octave
    , [string]$note
    , [string]$hold
    , [string]$lyric
  )

  # write the parameters to the console
  Write-Host "$octave : $($note.PadRight(2, " ")) : $hold : $lyric";

  # play the note (or just rest when a frequency is not defined)
  if (-not [String]::IsNullOrWhiteSpace($note))
  {

    # beep the speaker (adjusted for the missing C0, C1 and C2 octaves)
    [Console]::Beep( `
        [int][Math]::Round($notes[$note][$octave - 3]), ` # ex. $notes["C"][0]
        $holds[$hold]);                                   # ex. $holds["W"]
    
    # output the raw beep command (optional)
    if ($script.IsPresent)
    {
      Write-Output ("Write-Host `"$lyric`"; [Console]::Beep(" + `
        "$([int][Math]::Round($notes[$note][$octave - 3])), " + `
        "$($holds[$hold]));");
    }

  }

  # always rest to prevent the beeps from playing over each other
  Start-Sleep -Milliseconds ($holds[$hold]);

  # output the rest sleep command (optional)
  if ($script.IsPresent)
  {
    Write-Output ("Start-Sleep -Milliseconds $($holds[$hold]);");
  }

}

# write the title to the console
$title = "O Christmas Tree (Key of G)";
Write-Host;
Write-Host $title;

# output a title write command (optional)
if ($script.IsPresent)
{
  Write-Output "Write-Host `"$title`";";
}

# pause before
Start-Sleep -Milliseconds 1750;

# ---------------------------
Play-Note -octave 4 -note "D"  -hold "Q" -lyric "O";

Play-Note -octave 4 -note "G"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "G"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "A"  -hold "Q" -lyric "O";

Play-Note -octave 4 -note "B"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "How";

Play-Note -octave 4 -note "A"  -hold "E" -lyric "love-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "ly";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "are";
Play-Note -octave 4 -note "F#" -hold "Q" -lyric "thy";

Play-Note -octave 4 -note "A"  -hold "Q" -lyric "branch-";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "es!";
Play-Note -octave 4 -note "D"  -hold "Q" -lyric "O";

# ---------------------------
Play-Note -octave 4 -note "G"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "G"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "A"  -hold "Q" -lyric "O";

Play-Note -octave 4 -note "B"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "How";

Play-Note -octave 4 -note "A"  -hold "E" -lyric "love-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "ly";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "are";
Play-Note -octave 4 -note "F#" -hold "Q" -lyric "thy";

Play-Note -octave 4 -note "A"  -hold "Q" -lyric "branch-";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "es!";
Play-Note -octave 5 -note "D"  -hold "Q" -lyric "Your";

# ---------------------------
Play-Note -octave 5 -note "D"  -hold "E" -lyric "boughs";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "so";
Play-Note -octave 5 -note "E"  -hold "Q" -lyric "green";
Play-Note -octave 5 -note "D"  -hold "Q" -lyric "in";

Play-Note -octave 5 -note "D"  -hold "E" -lyric "Sum-";
Play-Note -octave 5 -note "C"  -hold "E" -lyric "mer-";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "time";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "Stay";

Play-Note -octave 5 -note "C"  -hold "E" -lyric "brave-";
Play-Note -octave 4 -note "A"  -hold "E" -lyric "ly";
Play-Note -octave 5 -note "D"  -hold "Q" -lyric "green";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "in";

Play-Note -octave 5 -note "C"  -hold "E" -lyric "Win-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "ter-";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "time.";
Play-Note -octave 4 -note "D"  -hold "Q" -lyric "O";

# ---------------------------
Play-Note -octave 4 -note "G"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "G"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "A"  -hold "Q" -lyric "O";

Play-Note -octave 4 -note "B"  -hold "E" -lyric "Chist-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "mas";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "tree";
Play-Note -octave 4 -note "B"  -hold "Q" -lyric "How";

Play-Note -octave 4 -note "A"  -hold "E" -lyric "love-";
Play-Note -octave 4 -note "B"  -hold "E" -lyric "ly";
Play-Note -octave 5 -note "C"  -hold "Q" -lyric "are";
Play-Note -octave 4 -note "F#" -hold "Q" -lyric "thy";

Play-Note -octave 4 -note "A"  -hold "Q" -lyric "branch-";
Play-Note -octave 4 -note "G"  -hold "Q" -lyric "es!";

# pause after
Start-Sleep -Milliseconds 750;