# Xiaomi Mi 4c/4s (libra/aqua) Kernel Build Workflow

Automated GitHub Actions CI/CD pipeline for building and packaging the **Linux 3.10.108** kernel for **Xiaomi Mi 4c (`libra`)** and **Xiaomi Mi 4s (`aqua`)** with **KernelSU (`xxksu`)**.

---

## 📱 Supported Devices

| Codename | Device Name | SoC / Platform | Base Kernel | KernelSU Support |
| :--- | :--- | :--- | :--- | :---: |
| **libra** | Xiaomi Mi 4c | Snapdragon 808 (MSM8992) | Linux 3.10.108 |  Built-in (`xxksu`) |
| **aqua** | Xiaomi Mi 4s | Snapdragon 808 (MSM8992) | Linux 3.10.108 |  Built-in (`xxksu`) |

---

## 🛠️ Build Matrix & Branch Selection

When triggering the workflow (`workflow_dispatch`), you can select from the following upstream kernel branches:

* **`lineage-18.1-ksu` (Default)**: Official KernelSU integrated branch maintained by `backslashxx`. Contains:
  * In-tree legacy KernelSU driver (`drivers/kernelsu`) with manual security hooks and syscall table hooks.
  * Backported Linux 4.1 OverlayFS (`CONFIG_OVERLAY_FS=y`).
  * Default configuration matching releases on [libra_manifests/releases](https://github.com/ximi-libra/libra_manifests/releases).
* **`susfs-3.10`**: Experimental SuSFS v1.5.5 NON-GKI port (`sus_path`, `try_umount`, `spoof_uname`).
* **`lineage-18.1`**: Upstream clean LineageOS 18.1 kernel baseline (without KernelSU).

---

## 📦 Package Output

The build pipeline automatically packages the generated `Image.gz-dtb` using **AnyKernel3**:
* Output format: `KSU_libra_3.10.108+<KSU_VERSION>-<YYMMDD>.zip`
* Flashable in TWRP / OrangeFox recoveries.
* Uploaded as a workflow artifact and optionally published as a GitHub Release.
