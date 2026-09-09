# SecureEdge-VPS: Enterprise-Grade Zero Trust Remote Access & Linux Hardening

![Security - Hardened](https://img.shields.io/badge/Security-Hardened-brightgreen?style=for-the-badge&logo=shield)
![OS - Ubuntu LTS](https://img.shields.io/badge/OS-Ubuntu_LTS-E95420?style=for-the-badge&logo=ubuntu)
![Infrastructure - Oracle Cloud](https://img.shields.io/badge/Infrastructure-Oracle_Cloud_(Zurich)-F80000?style=for-the-badge&logo=oracle)
![Protocol - Hysteria2 / QUIC](https://img.shields.io/badge/Protocol-Hysteria2_/_QUIC-0052CC?style=for-the-badge)
![Encryption - XTLS--Reality](https://img.shields.io/badge/Encryption-XTLS--Reality-black?style=for-the-badge)
![DNS - DoH / DoQ](https://img.shields.io/badge/DNS-DoH_/_DoQ-43B02A?style=for-the-badge&logo=adguard)

An enterprise-ready, defense-in-depth infrastructure deployment on an **Oracle Cloud VPS (Zurich Region)**. This repository documents the implementation of a zero-trust encrypted transport overlay combined with granular kernel-level host hardening, network perimeter defense, and encrypted DNS threat intelligence filtering.

Designed to withstand modern Deep Packet Inspection (DPI), state-sponsored adversary simulation (e.g., Pegasus/Predator C2 callbacks), and persistent host-level intrusion vectors.

---

## 🏗️ Architecture Overview

The architecture follows a strict **Defense-in-Depth** model layered across the OSI stack, routing ingress transport traffic through obfuscated protocols while enforcing host-level isolation and encrypted DNS resolution.

```text
[ Client Endpoint (Android/Linux) ]
               │
               │  Encrypted Transport (Layer 4/7)
               │  - Hysteria2 (UDP/QUIC + BBR Congestion)
               │  - Xray VLESS (XTLS-Reality SNI Spoofing)
               ▼
┌────────────────────────────────────────────────────────────────────────┐
│ Oracle Cloud VPS (Ubuntu LTS) - Zurich Region                          │
│                                                                        │
│ ┌────────────────────────────────────────────────────────────────────┐ │
│ │ Network Perimeter & Host Defense (OSI Layers 3/4)                  │ │
│ │ ├── UFW Firewall (Strict Ingress Whitelisting)                     │ │
│ │ ├── Fail2ban (Automated SSH & Service Brute-Force Jails)           │ │
│ │ └── Sysctl Kernel Hardening (rp_filter, tcp_syncookies, No-Redirects)│ │
│ └────────────────────────────────┬───────────────────────────────────┘ │
│                                  │                                     │
│ ┌────────────────────────────────▼───────────────────────────────────┐ │
│ │ Ingress Routing & Management (3x-ui Core Engine)                   │ │
│ │ └── Xray-core / Hysteria2 Service Multiplexing                     │ │
│ └────────────────────────────────┬───────────────────────────────────┘ │
│                                  │                                     │
│ ┌────────────────────────────────▼───────────────────────────────────┐ │
│ │ Encrypted DNS Resolver & Threat Intelligence (OSI Layer 7)         │ │
│ │ └── AdGuard Home via DoH (HTTPS) & DoQ (QUIC)                      │ │
│ │     ├── ThreatFeeds: Malware, Phishing, C2 Botnets                 │ │
│ │     └── Advanced Telemetry & Spyware Blocklists (Pegasus/Predator) │ │
│ └────────────────────────────────┬───────────────────────────────────┘ │
└──────────────────────────────────┼─────────────────────────────────────┘
                                   │
                                   ▼
                    [ Clean Egress to Web / WAN ]
