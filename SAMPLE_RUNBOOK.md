### Issue: Load Balancer is not distributing logs to rsyslog containers.

#### Runbook to Fix the Issue:

1. Check Container Status:
   * Run the command: `docker-compose ps` to ensure that all containers are running without any errors. Verify that the load balancer and rsyslog containers are in the "Up" state.
2. Verify NGINX Configuration:
   * Check the `nginx.conf` file for any syntax errors or misconfigurations.
   * Make sure the `upstream` section of the NGINX configuration specifies the correct container names (`rsyslog1` and `rsyslog2`) and port (`514`) for the rsyslog containers.
3. Verify rsyslog Configuration:
   * Check the `rsyslog.conf` files in the `rsyslog1` and `rsyslog2` directories for any errors or misconfigurations.
   * Ensure that the rsyslog configuration is set to listen on port `514` for incoming log messages.
4. Check Networking:
   * Verify that there are no firewall rules or security groups blocking incoming traffic on port `514` to the load balancer and rsyslog containers.
   * Check if any other service or process is already bound to port `514` on the host machine, which can cause conflicts. Resolve the conflict by either stopping the conflicting service or changing the port binding in the `docker-compose.yml` file.
5. Test Log Ingestion:
   * Send log messages directly to the IP address of the load balancer on port `514` using tools like `logger` or `curl`. Verify if the logs are being distributed to the rsyslog containers.
   * If the logs are not reaching the rsyslog containers, check for any errors or network connectivity issues.
6. Restart the Containers:
   * Run the command: `docker-compose restart` to restart the containers. This can help resolve any temporary issues.
7. Monitor Container Logs:
   * Use the command: `docker logs <container_name>` to view the logs of the load balancer and rsyslog containers.
   * Check for any error messages or warnings related to the log distribution process.
8. Update Container Images:
   * Check if there are any newer versions of the rsyslog and NGINX images available.
   * Update the image versions in the `docker-compose.yml` file and run the command: `docker-compose pull` to pull the latest images.
9. Troubleshooting Resources:
   * Refer to the official documentation of rsyslog and NGINX for troubleshooting guides and community support.
   * Check Docker logs and system logs for any relevant error messages or warnings.
10. Seek Further Assistance:
    * If the issue persists, seek assistance from relevant forums, communities, or consult with experienced professionals to troubleshoot the specific issue in your environment.
