# LOS

Just an OS dev side project I'm working on.

# Progress Pictures

VGA Graphics support in kernel:

![image](https://github.com/user-attachments/assets/cfd9afb4-e396-4663-9a46-360e27509734)

# Project Roadmap

| Supported?  | OS Feature |
| :-------------: | ------------- |
| :heavy_check_mark:  | BIOS Bootloader |
| :heavy_check_mark:  | VGA Graphics Mode |
| :heavy_check_mark: (after slight modification)  | Text Mode |
| :heavy_check_mark:  | Floppy |
| :triangular_flag_on_post:  | ISO |
| :warning:  | UEFI Bootloader |
| :warning:  | Simple Filesystem Support |
| :warning:  | Mouse and Keyboard Input Handling |
| :warning:  | User Programs / Executable Loading |
| :warning:  | Simple 3D Graphics Demo (wireframe cube) |
| :x:  | Basic Timer/RTC Support |
| :x:  | Basic Shell or Command Line |
| :x:  | Sound Output (PC Speaker or basic audio) |
| :x:  | Internet Connection (UDP Stack) |
| :x:  | Web Browser |

- :heavy_check_mark: Supported
- :warning: Planned Future Development
- :x: Currently Unsupported (potentially in the far future)
- :triangular_flag_on_post: Next item in development

# Build And Run Instructions

Running the build script will give you info on any missing packages you may need.

- Build and Run BIOSBootloader with Kernel (from root directory "LOS/"):
```bash
./buildBIOS.sh
```
- Build and Run UEFIBootloader with Kernel (from root directory "LOS/"):
```
coming soon...
```

# Resources:
- [os-tutorial](https://github.com/cfenollosa/os-tutorial/tree/master)
- [osdev wiki](https://wiki.osdev.org/Expanded_Main_Page)
