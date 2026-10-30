# Xiaomi Mi 4c/4s (libra/aqua) Kernel Build Workflow

Automated GitHub Actions CI/CD pipeline for building and packaging the **Linux 3.10.108** kernel for **Xiaomi Mi 4c (`libra`)** and **Xiaomi Mi 4s (`aqua`)** with **KernelSU (`xxksu`)** and **SuSFS v2.3.0**.

---

## 📱 Supported Devices

| Codename | Device Name | SoC / Platform | Base Kernel | KernelSU Support | SuSFS Support |
| :--- | :--- | :--- | :--- | :---: | :---: |
| **libra** | Xiaomi Mi 4c | Snapdragon 808 (MSM8992) | Linux 3.10.108 |  Built-in (`xxksu` 32704) |  v2.3.0 |
| **aqua** | Xiaomi Mi 4s | Snapdragon 808 (MSM8992) | Linux 3.10.108 |  Built-in (`xxksu` 32704) |  v2.3.0 |

---

## 🛠️ Matrix Build Strategy

The workflow runs a parallel **matrix build** on the upstream base branch (`personal`):

1. **Non-SuSFS**:
   - Upstream base: `yapixel/android_kernel_xiaomi_libra` branch `personal`
   - Applies manual syscall hooks (`fs/exec.c`, `fs/open.c`, `fs/stat.c`) via `patches/01_ksu_manual_hooks.patch`
   - Applies manual security hooks v2.0 (`security/security.c`) via `patches/02_ksu_manual_security_hooks.patch`
   - Disables branch-link hack and dynamic LSM hooking for clean manual operation
   - Output: `KSU_libra_3.10.108+<KSU_VER>-<DATE>.zip`

2. **SuSFS v2.3.0**:
   - Applies manual syscall & security hooks
   - Clones and applies SuSFS v2.3.0 patches from [yapixel/susfs4ksu](https://github.com/yapixel/susfs4ksu) (branch `kernel-3.10`):
     - `kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch`
     - `kernel_patches/50_add_susfs_in_kernel-3.10.patch`
     - `kernel_patches/fs/susfs.c`, `susfs.h`, `susfs_def.h`
   - Enables full SuSFS features (`CONFIG_KSU_SUSFS=y`, etc.)
   - Output: `KSU_SUSFS_v2.3.0_libra_3.10.108+<KSU_VER>-<DATE>.zip`

Both packages are compiled in parallel and automatically published together in a single GitHub Release.
