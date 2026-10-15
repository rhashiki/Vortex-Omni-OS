# Dependency audit — open issues

Status: **NOT APPROVED**.

| Candidate | Main concern | Required action |
|---|---|---|
| Universal Blue Kinoite base | May include non-free firmware/codecs and trademarked assets | Inventory image packages, firmware and licensing; replace base if strict FOSS cannot be achieved |
| Fedora base | Fedora guidelines and third-party packaging differ from strict all-FOSS requirement | Review exact image manifest and package sources |
| KDE Plasma/KWin | Mixed copyleft licenses and bundled assets | Preserve notices/source and review assets |
| Wine/Proton | Distribution and build dependencies | Audit pinned releases and included components |
| Waydroid | Android image contents and proprietary additions | Select auditable free AOSP image |
| ArtCraft family | Trademark and optional paid external services | Remove mandatory service dependencies and rebrand forks if required |
| AI models | Model licenses may not be OSI-approved | Use separately audited open-weight/open-source compatible models |

**No upstream dependency is approved for distribution solely on the basis of its public repository.**
