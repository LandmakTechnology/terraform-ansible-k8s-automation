#!/bin/python
# Shebang Line Should Point Python Installation Path
import pprint
import boto3
import json


def getgroupofhosts(ec2):
    allgroups = {}

    for each_in in ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}]):
        for tag in each_in.tags:
            if tag["Key"] in allgroups:
                hosts = allgroups.get(tag["Key"])
                hosts.append(each_in.public_ip_address)
                allgroups[tag["Key"]] = hosts
            else:
                hosts = [each_in.public_ip_address]
                allgroups[tag["Key"]] = hosts

            if tag["Value"] in allgroups:
                hosts = allgroups.get(tag["Value"])
                hosts.append(each_in.public_ip_address)
                allgroups[tag["Value"]] = hosts
            else:
                hosts = [each_in.public_ip_address]
                allgroups[tag["Value"]] = hosts

    return allgroups


def main():
    ec2 = boto3.resource("ec2")
    all_groups = getgroupofhosts(ec2)
    inventory = {}
    for key, value in all_groups.items():
        hostsobj = {'hosts': value}
        inventory[key] = hostsobj
    print(json.dumps(inventory))


if __name__ == "__main__":
    main()
