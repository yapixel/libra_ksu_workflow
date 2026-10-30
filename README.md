# Xiaomi Mi 4c (libra) Kernel Build Workflow

Automated GitHub Actions CI/CD pipeline for building and packaging the **Linux 3.10.108** kernel for **Xiaomi Mi 4c (`libra`)** with **KernelSU (`xxksu`)** and **SuSFS v2.3.0**.

---

## 📱 Supported Devices

| Codename | Device Name | SoC / Platform | Base Kernel | KernelSU Support | SuSFS Support |
| :--- | :--- | :--- | :--- | :---: | :---: |
| **libra** | Xiaomi Mi 4c | Snapdragon 808 (MSM8992) | Linux 3.10.108 |  `xxksu` (Auto-latest / 32707+ / Built-in) |  v2.3.0 |

---

## 🛠️ Matrix Build Strategy

The workflow runs a parallel **matrix build** on the upstream base branch (`personal`):

1. **KernelSU (`xxksu`) Management**:
   - Supports auto-fetching latest upstream [backslashxx/KernelSU](https://github.com/backslashxx/KernelSU) (default: `latest`).
   - Supports targeting specific branch / tag or falling back to `builtin` (in-tree version).

2. **Hook Modes**:
   - `manual`: Static C compile-time hooks (`fs/exec.c`, `fs/open.c`, `fs/stat.c`, `security/security.c`).
   - `lsm`: Upstream dynamic ARM64 opcode & LSM runtime binary hooking.
   - Separate matrix displays for clear tracking and concurrent builds.

3. **SuSFS Integration**:
   - **Non-SuSFS**: Clean KernelSU build.
   - **SuSFS v2.3.0**: Applies SuSFS v2.3.0 patches from [yapixel/susfs4ksu](https://github.com/yapixel/susfs4ksu) (branch `kernel-3.10`).

Output packages:
- `KSU_libra_3.10.108+<KSU_VER>-<HOOK>-<DATE>.zip`
- `KSU_SUSFS_v2.3.0_libra_3.10.108+<KSU_VER>-<HOOK>-<DATE>.zip`

Both packages are compiled in parallel and automatically published together in a single GitHub Release.
