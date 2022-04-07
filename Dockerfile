FROM osrf/ros:melodic-desktop-full

RUN apt-get update
RUN apt-get install -y git
RUN apt-get -y install sudo

RUN apt-get -y install python3-pip
RUN apt-get -y install python3-tk

RUN apt-get -y install nano
RUN apt-get -y install tmux

RUN apt-get -y install ros-melodic-plotjuggler-ros
RUN apt-get -y install libyaml-cpp-dev

RUN apt-get -y install libgeographic-dev

ENV USERNAME seong
RUN useradd -U -ms /bin/bash $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd # password is same with USERNAME
RUN echo "$USERNAME ALL=(ALL:ALL) ALL" > /etc/sudoers

RUN echo "# for ROS1" >> /home/$USERNAME/.bashrc
RUN echo "source /home/$USERNAME/docker_ws/ros1/dev_ws/install/setup.bash" >> /home/$USERNAME/.bashrc

RUN echo "alias eb='nano /home/$USERNAME/.bashrc'" >> /home/$USERNAME/.bashrc
RUN echo "alias sb='source /home/$USERNAME/.bashrc'" >> /home/$USERNAME/.bashrc
RUN echo "alias ws='cd /home/$USERNAME/docker_ws/ros1/dev_ws'" >> /home/$USERNAME/.bashrc
RUN echo "alias cb='cd /home/$USERNAME/docker_ws/ros1/dev_ws && colcon build'" >> /home/$USERNAME/.bashrc
RUN echo "alias si='. /home/$USERNAME/docker_ws/ros1/dev_ws/install/setup.bash'" >> /home/$USERNAME/.bashrc

RUN /bin/bash -c "source /home/$USERNAME/.bashrc"

USER $USERNAME

RUN rosdep update

# Docker run commands
# - mkdir /home/$USERNAME/docker_ws/ros1
# - docker build -t osrf/ros-melodic-user .
# - docker run --gpus all -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USERNAME/docker_ws/ros1:/home/$USERNAME/docker_ws/ros1 -e DISPLAY=$DISPLAY -e TZ=$(cat /etc/timezone) --env="NVIDIA_VISIBLE_DEVICES"=all --env="NVIDIA_DRIVER_CAPABILITIES"=all osrf/ros-melodic-user:latest


# RUN /bin/bash -c "cd $HOME/docker_ws/ros1/dev_ws"
# RUN rosdep install --from-paths src/external/rviz_visual_tools --ignore-src --rosdistro ${ROS_DISTRO}

# RUN apt install -y libmatio-dev
# RUN cd /home/$USERNAME
# RUN git clone https://github.com/dic-iit/matio-cpp
# RUN cd matio-cpp
# RUN mkdir build && cd build
# RUN cmake ../
# RUN make
# RUN make install
