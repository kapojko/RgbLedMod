# RgbLedMod

Verilog core for managing 3-wire RGB PWM Led (full colors) with blinking support.

## Module parameters

The following parameters are configurable:

* Blink period (full cycle on/off) in clock cycles
* LED on value (1 for active high, 0 for active low)
* LED off value (0 for active high, 1 for active low)

## Simulation

For simulation purpose, testbench `RgbLed_tb` is provided.

Simulation is performed with [DSim Desktop](https://www.metrics.ca/) using _VS Code_ extension and local desktop simulator. Simulation configuration is stored in `sim` directory.

Steps for simulation:

* Ensure that VSCode extension is installed (*metrics-design-automation.dsim-desktop*).
* Install local tool (using extension panel).
* Click *Manage Licenses* button and activate free personal license.
    * NOTE: only one license is allowed.
    * License may be downloaded and manually put to `AppData/Local/metrics-ca` directory.
* Create `sim` directory.
* Right click on `sim` directory and create new *DSim* project with root directory `..\`.
* Right click on Verilog files and add them to project using *Configure File* command.
* Go to *Library configuration* panel and compile *work* library.
* Create the simulation *RgbLed_sim* with the following options: `-top work.RgbLed_tb +acc+b -waves waves.mxd`.
* Run simulation.
* Open `waves.mxd` file for analysis.

*Note:* See [Tutorial](https://help.metrics.ca/support/solutions/articles/154000141163) for more details on installation, configuration and running.

## Author

Yuriy Kapoyko - ykapoyko@vk.com
