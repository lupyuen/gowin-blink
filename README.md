# gowin-blink
Blink demo for GOWIN FPGA dev kit DK-START-GW1N4, based on GW1N-4 FPGA with 4K LUTs

`http://www.gowinsemi.com/support/devkits_detail/1/`

- Download the files in this repo and open `fpga_project` in Gowin YunYuan IDE

- Verilog code was reproduced from _"SUG100-1.2E_Gowin YunYuan Software User Guide"_

- Floorplanner config based on _"DK-START-GW1N4 User Guide"_
    and _"DK-START-GW1N4开发板原理图"_

- Official docs are at `http://www.gowinsemi.com/support/database/`

-----
## Programming the GOWIN FPGA

1. Obtain a free developer licence from GOWIN. You will receive 2 licence files. 
    Set the `LM_LICENSE_FILE` environment
    variable to the full path of the `gowin_Synplifypro_????????????.lic` licence file.

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-licence.png">

1. In GOWIN YunYuan IDE, set the local licence file to the other
    `gowin_????????????.lic` licence file (not the same as the previous licence file).

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-licence2.png">

1. Set the FPGA device as follows:

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-device.png">

1. Our demo consists of a single Verilog file `demo.v`:

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-source.png">

1. Run the `Synthesize` step.  Open the `FloorPlanner` and set the Ports to the
    following Locations (i.e. the FPGA pin numbers)

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-floorplanner.png">

1. Run the `Place & Route` step, then `Program Device`.  Go to the `Cable Settings` screen and click `Query`.  Make sure that the USB cable is connected AND the dev board is powered up via the AC adapter.

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-programmer-cable.png">

1. Click the `Program` button to copy the program into static RAM. The `Done` LED lights up and the demo code starts running, flashing the 4 LEDs at the bottom edge of the dev board.

    <img alt="" src="https://raw.githubusercontent.com/lupyuen/gowin-blink/master/images/gowin-programmer.png">

