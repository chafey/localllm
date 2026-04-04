# Hardware

* Motherboard: [ASUS PRO WS WRX90E-SAGE SE CEB](https://www.asus.com/us/motherboards-components/motherboards/workstation/pro-ws-wrx90e-sage-se/)
* CPU: [AMD Ryzen Threadripper PRO 9965WX 24-Cores](https://www.amd.com/en/products/processors/workstations/ryzen-threadripper/9000-wx-series/amd-ryzen-threadripper-pro-9965wx.html)
* CPU Cooler: [Arctic Freeer 4U-M](https://www.arctic.de/us/Freezer-4U-M/ACFRE00133A)
* RAM: 256GB DDR5 (8X32GB) [Kingston FURY Renegade Pro RDIMM Memory](https://www.kingston.com/en/memory/gaming/fury-renegade-ddr5-pro-rdimm?speed=5600mt%2Fs&total%20(kit)%20capacity=128gb&kit=kit%20of%204&dram%20density=16gbit&profile%20type=amd%20expo%20%2F%20intel%20xmp)
* nVME: [Crucial T705 4TB PCIE 5.0](https://www.crucial.com/ssd/t705/ct4000t705ssd3)
* GPU1: [PNY RTX PRO 6000 Blackwell Max-Q Workstation Edition](https://www.pny.com/nvidia-rtx-pro-6000-blackwell-max-q)
* GPU2: [PNY RTX PRO 6000 Blackwell Max-Q Workstation Edition](https://www.pny.com/nvidia-rtx-pro-6000-blackwell-max-q)
* Power Supply: [Super Flower Leadex Titanium 2800 Watt ATX3.1](https://www.super-flower.com.tw/en/products/leadex-titanium-2800w-20250526150946)
* Case: [Cooler Master MasterFrame 700](https://www.coolermaster.com/en-us/products/masterframe-700/)

## Notes

* Motherborad, RAM and CPU were specifically selected to achieve [272 GB/s memory bandwidth](https://www.reddit.com/r/LocalLLaMA/comments/1mcrx23/psa_the_new_threadripper_pros_9000_wx_are_still)
* Motherboard was specifically selected to support full PCIe 5.0 x16 bandwidth for up to 4 GPUs
* GPU was specifically selected to support low power use, exhausting air out the back and stacking up to 4 GPUs directly on motherboard
* Power Supply was specifically selected to support 12VHPWR up to 4 GPUs
* Motherboard IPMI was disabled as it was causing problems during boot
