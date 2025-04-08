#!/bin/bash

# Create system users
sudo adduser --disabled-password --gecos automatic admission
sudo adduser --disabled-password --gecos automatic coordinator
sudo adduser --disabled-password --gecos automatic ta1
sudo adduser --disabled-password --gecos automatic ta2
sudo adduser --disabled-password --gecos automatic student1
sudo adduser --disabled-password --gecos automatic student2
sudo adduser --disabled-password --gecos automatic student3
sudo adduser --disabled-password --gecos automatic student4

sudo passwd -d admission
sudo passwd -d coordinator
sudo passwd -d ta1
sudo passwd -d ta2
sudo passwd -d student1
sudo passwd -d student2
sudo passwd -d student3
sudo passwd -d student4

# Create groups to associate specific users and control group permissions
sudo groupadd faculty
# sudo groupadd students

# Add coordinator and TAs to faculty group
sudo usermod -a -G faculty coordinator
sudo usermod -a -G faculty ta1
sudo usermod -a -G faculty ta2

# Create specific groups for TAs and respective students
sudo groupadd ta-student1
sudo usermod -a -G ta-student1 student1
sudo usermod -a -G ta-student1 ta1
sudo usermod -a -G ta-student1 ta2

sudo groupadd ta-student2
sudo usermod -a -G ta-student2 student2
sudo usermod -a -G ta-student2 ta1
sudo usermod -a -G ta-student2 ta2

sudo groupadd ta-student3
sudo usermod -a -G ta-student3 student3
sudo usermod -a -G ta-student3 ta1
sudo usermod -a -G ta-student3 ta2

sudo groupadd ta-student4
sudo usermod -a -G ta-student4 student4
sudo usermod -a -G ta-student4 ta1
sudo usermod -a -G ta-student4 ta2


# Create grades-reported directory
mkdir grades-reported


# Change ownership of grades-reported directory - owner: coordinator, group: faculty
sudo chown coordinator:faculty grades-reported

# Change permissions of grades-reported directory - owner: rwx, group: none, others: none
sudo chmod 0700 grades-reported

# Create grades folder
mkdir registered-students

# Move into registered-students directory
cd registered-students

# Create directories for each student
mkdir student1 student2 student3 student4

# Create/add files corresponding to assignment to respective student directories
echo "A" > student1/assignment1
echo "B" > student2/assignment1
echo "F" > student3/assignment1

# Change ownership for respective student directories
sudo chown coordinator:ta-student1 student1
sudo chown coordinator:ta-student2 student2
sudo chown coordinator:ta-student3 student3
sudo chown coordinator:ta-student4 student4

# Change permissions for respective student directories - owner: rwx, group: rx, other: none
sudo chmod 0750 student1
sudo chmod 0750 student2
sudo chmod 0750 student3
sudo chmod 0750 student4

# Change ownership and permissions for specific files within student directories - owner: rwx, group: rw, others: r
sudo chown coordinator:faculty student1/assignment1
sudo chmod 0764 student1/assignment1

sudo chown coordinator:faculty student2/assignment1
sudo chmod 0764 student2/assignment1

sudo chown coordinator:faculty student3/assignment1
sudo chmod 0764 student3/assignment1


cd ..
 
# Change ownership of registered-students dir - owner: admission, group: faculty
sudo chown admission:faculty registered-students

# Change permissions of registered-students dir - owner: rwx, group: rx, others = rx
sudo chmod 0755 registered-students
