MDF Signal Editor 1.0 - offline tool to modify / add / delete signals in MDF files
===============================================================================

Works fully offline. Reads MDF 3.x and MDF 4.x (.mdf, .mf4). Writes a NEW file
in the same MDF version - the original file is never changed.


SETUP (Windows)
---------------
Option A - with Python installed (3.9 or newer):
  1. Double-click run_editor.bat
     (first start installs asammdf + matplotlib; after that no internet needed)

Option B - standalone .exe (for PCs without Python / without internet):
  1. On any PC with Python + internet, double-click build_exe.bat
  2. Copy dist\MDF_Signal_Editor.exe to the target PC and run it.


HOW TO USE
----------
1. Open MDF file...        -> all signals are listed (unit, samples, rate, min/max).
                              Use the Search box to filter.
2. Define a change:
     Modify selected signal  - select the signal in the list
     Add new signal          - type the new name; choose the time base
                               ("Same as signal" = copy its timestamps, recommended,
                               or a fixed rate in ms over the whole file duration)
     Delete selected signal
   Enter time (s) and value, one pair per line:
       0 0
       10 1
       58 0
   (also accepted: 0:0; 10:1; 58:0  - or paste two columns from Excel)

   Step (default)  : value is held until the next time -> 0 until 10 s,
                     1 from 10 s, 0 again from 58 s.
   Linear ramp     : values are interpolated between the points.
   Only change from/to (Modify only): changes values only inside that time
                     window, original values are kept outside.

   Preview plot shows original vs new.  Then click "Add to change list".
3. Repeat for as many signals as you need (pending changes list).
4. Generate modified MDF file...  -> choose the output name -> done.

Note: for signals with a value-to-text table (enum), enter the raw numbers.


COMMAND LINE / AUTOMATION
-------------------------
List signals:
  python mdf_signal_editor.py input.mdf --list

Add FLAG_0 (0 -> 1 at 10 s -> 0 at 58 s) on the same time base as FLAG_1:
  python mdf_signal_editor.py input.mdf -o output.mdf ^
     --add CM.TC_INDICATOR_FLAG.FLAG_0 --points "0:0;10:1;58:0" ^
     --ref CM.TC_INDICATOR_FLAG.FLAG_1

Set CM.Car.v to 2 only between 20 s and 30 s:
  python mdf_signal_editor.py input.mdf -o output.mdf ^
     --modify CM.Car.v --points "0:2" --window 20 30

Other options: --delete NAME, --mode linear, --rate-ms 10, --dtype uint8, --unit m/s
Several --add/--modify can be combined; give one --points for each, in order.
With the .exe use: MDF_Signal_Editor.exe input.mdf --list   (same options)
