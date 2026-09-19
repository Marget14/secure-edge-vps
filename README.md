# Secure Edge VPS — Enterprise Proxy & Monitoring Infrastructure

A high-performance, Zero-Trust hardened proxy edge stack deployed on Oracle Cloud Infrastructure (ARM64). Built for automated deployment, secure DNS routing, and real-time observability.

---

## 📐 Architecture Overview

```text
               +-------------------------------------------------+
               |                  Android Client                 |
               |  - Private DNS: Off (Handled inside Tunnel)     |
               |  - NekoBox Tunnel (Remote DNS: Quad9 / Cloudflare)|
               +------------------------+------------------------+
                                        |
                             Hysteria 2 / VLESS-Reality
                                        |
                                        v
+-----------------------------------------------------------------------------------+
| Oracle Cloud VPS (Ubuntu ARM64)                                                   |
|                                                                                   |
|  +-----------------------+     +-----------------------+     +-----------------+  |
|  |   UFW Firewall        | --> |   3x-ui Panel         | --> | Quad9 DoH       |  |
|  |   - UDP 8443 (Hy2)    |     |   - Docker Container  |     | (Encrypted DNS) |  |
|  |   - TCP 8443 (Reality)|     |   - Port 48291        |     +-----------------+  |
|  +-----------------------+     +-----------------------+                          |
|                                                                                   |
|  +-----------------------------------------------------------------------------+  |
|  | Observability Stack                                                         |  |
|  | Prometheus (Metrics Collector) <---> Grafana (Interactive Dashboards)      |  |
|  +-----------------------------------------------------------------------------+  |
+-----------------------------------------------------------------------------------+
