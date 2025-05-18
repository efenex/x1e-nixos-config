{
  lib,
  fetchFromGitHub,
  buildLinux,
  linuxPackagesFor,
  fetchpatch,
  fetchurl,
  ...
}:

linuxPackagesFor (buildLinux {
  src = fetchgit {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git";
    rev = "refs/tags/next-20250516";
    hash = "8e7386987569f6c99e6dc86d939476350049b9fd";
  };

  version = "6.15.0-rc6";
  defconfig = "johan_defconfig";

  structuredExtraConfig = with lib.kernel; {
    VIRTUALIZATION = yes;
    KVM = yes;
    MAGIC_SYSRQ = yes;
  };

  # TODO: Look into the errors and remove this.
  ignoreConfigErrors = true;

  kernelPatches = [
    {
      name = "phy: qcom: phy-qcom-snps-eusb2: Make repeater optional";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0004-phy-qcom-phy-qcom-snps-eusb2-Make-repeater-optional.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "dt-bindings: usb: Add Parade PS8833 Type-C retimer variant";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0009-dt-bindings-usb-Add-Parade-PS8833-Type-C-retimer-var.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "arm64: dts: qcom: Add support for X1-based Asus Zenbook A14";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0012-arm64-dts-qcom-Add-support-for-X1-based-Asus-Zenbook.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "arm64: dts: qcom: support sound on Asus Zenbook A14";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0013-arm64-dts-qcom-support-sound-on-Asus-Zenbook-A14.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "WIP: arm64: dts: qcom: HDMI support on Asus Zenbook A14";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0014-WIP-arm64-dts-qcom-HDMI-support-on-Asus-Zenbook-A14.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "arm64: dts: qcom: support camera on Asus Zenbook A14";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0015-arm64-dts-qcom-support-camera-on-Asus-Zenbook-A1.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }
    {
      name = "arm64: dts: qcom: x1-asus-zenbookk-a14.dtsi: rotate";
      patch = fetchurl {
        url = "https://raw.githubusercontent.com/alexVinarskis/linux-x1e80100-zenbook-a14/refs/heads/master/0017-arm64-dts-qcom-x1-asus-zenbookk-a14.dtsi-rotate-webc.patch";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
      };
    }

    # DP altmode
    {
      name = "arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: add retimers, dp altmode support";
      patch = fetchpatch {
        url = "https://lore.kernel.org/lkml/20250417-slim7x-retimer-v2-1-dbe2dd511137@oldschoolsolutions.biz/raw";
        hash = "sha256-rtxQ6f/mqXED3JjBRc0SYeALNfClPlpbpFFz66zfsZc=";
      };
    }

    # Patch for getting some limited aDSP functionality in EL2 (e.g. battery status)
    {
      name = "WIP: remoteproc: q6v5-pas: Attach to lite ADSP firmware";
      patch = fetchpatch {
        url = "https://git.codelinaro.org/stephan.gerhold/linux/-/commit/7c2a82017d32a4a0007443680fd0847e7c92d5bb.patch";
        hash = "sha256-LNAjF4eNkGiKhlVlXg8FJ8TtXmuR3u+ct0cas7nzM4E=";
      };
    }
  ];
})
