**Traceability and Verification of Reproducibility in NixOS Systems**
*Mapping Nix store paths to git revisions across hosts and time*

In a fleet of NixOS hosts, ensuring traceability and reproducibility is important for reliable operations. This project addresses that challenge for NixOS-based systems by developing a system that maps Nix store paths back to their corresponding git revisions(path-revision mapping) and tracks the current system information of each host. This makes the NixOS system state and activation history of every host observable, enabling verification that systems are running the same software and configuration, and detection of anomalies.

The goal is to design and implement a system that tracks path-revision mapping, and monitors the current state of hosts. This is important for two reasons:

1. Consistency within a cluster. We want to know if the hosts in a cluster are running the same configuration and software. There might be slight variations with in a cluster, such as hostnames and network settings, but as long as their different store paths correspond to the same commit, we can confirm that they are still consistent
2. Reproducibility across time. If the path-revision mapping shows that the same store path corresponds to multiple commits, this shows that the commits did not alter the system state. This property can be used, to confirm that a refactoring has not unintentionally changed the system.

At first glance, one might attempt to embed the current commit hash directly into the system definition during the build. However, this is problematic, because baking the commit hash into the build means that every commit will produce a unique store path, making it meaningless to compare store paths across commits, and also undermining the ability to verify that changes leave the resulting system unchanged.

The system will consist of the following parts:
 - *Collector*, collects and stores information from all hosts about NixOS activations, and receives path-revision mapping to integrate with that data.
 - *Publisher*, a lightweight service on each host that makes its current system state and activation history available to the *collector*.
 - *Visualizer*, presents the data, the *collector* has received, providing a fleet wide overview (hostname, store path, commit hash, branch) and per host timelines of NixOS system activations (including time, user action and arguments)

To make the path-revision mappings available, the CI pipeline must record these mappings. This integration is not part of the system itself, but it is a necessary step to ensure that path-revision information is consistently available for the *collector*.

Together, these components form a monitoring layer for NixOS deployments. This project focuses specifically on NixOS system state traceability, path-revision mapping, recording NixOS system activations and using these to provide both a current and a historical view into a fleet of servers. In doing so, the project not only addresses the technical challenge of path-revision mapping but also the much broader challenge of traceability, verification of reproducibility in NixOS systems across hosts and time.

