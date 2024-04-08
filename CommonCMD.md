## 路径匹配

```shell
 # 1. 匹配杀死进程
 ps aux | grep "python3 tools/test.py" |  awk '{print $2}' | xargs kill -9
 
 # 2. 文件夹下文件绝对路径保存到文件
 ls data/FCM/ | sed "s:^:`pwd`/data/FCM/:" > image_list.txt
```

## 文件下载

```shell
 # 1. wget
 # ref: https://blog.csdn.net/wuhuagu_wuhuaguo/article/details/90764856#t9
 # ref: ruanyifeng.com/blog/2019/09/curl-reference.html
 wget -c -O file.tar.gz "https://..."
 
 # 2. curl
 curl -L -C - "https://cn-beijing-data.aliyundrive.net/Gb..." -o "v1.0-test_blobs.tar" -e "https://www.aliyundrive.com/"
 
 
 # 3. google driver
 # ref: https://www.cnblogs.com/aoru45/p/11990040.html
 https://api.moeclub.org/GoogleDrive/${FileID}
 # 其他
 # 1: 普通接口模式 ( 不能断点续传, 一些下载软件不能正确获取文件名, 走谷歌CDN. )
 # https://api.moeclub.org/GoogleDrive/
 # 2: 高级接口模式 ( 支持断点续传, 能正确获取文件名, 走CloudFare CDN, 支持中国等地区, 速度可能没接口#1快. )
 # https://api.moeclub.org/GoogleDrive//NoLimit
 
```


## docker

```shell
 # docker install refer https://www.runoob.com/docker/ubuntu-docker-install.html
 sudo service docker start    # 开启dockers

 # 导入镜像
 docker pull nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04
 docker load -i xxx.tar.gz
 
 
 # 创建容器
 docker run -itd --name=cu116 --network=host -v /usr/bin/:/usr/bin/ -v /home/hushaobao:/home/hushaobao -w /usr/local/neuware/samples/magicmind  yellow.hub.cambricon.com/magicmind/release/x86_64/magicmind:0.13.0-x86_64-ubuntu18.04-py_3_7 bash
 docker run  -u hushaobao -itd -p 9666:22  --restart always --gpus all --shm-size 126G -v /home/hushaobao/:/home/hushaobao/ --name=cu116 11.6.0-cudnn8-runtime-ubuntu18.04 /usr/bin
 
 # 开启
 docker start "container_id/name"
 
 # 进入docker
 docker exec -it name /bin/bash
 
```



## 工具库

### 1. googletest

### 2. googlelog

### 3. spdlog

### 4. protobuf

### 5. boost

#### 5.1 install

```bash
 wget https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz
 tar -xvf boost_1_76_0.tar.gz && cd boost_1_76_0
 ./bootstrap.sh --with-libraries=all --with-toolset=gcc
 ./b2 toolset=gcc
 sudo ./b2 install --prefix=/usr  # default install path:　/usr/local/
 sudo ldconfigs
```

- 中文文档：https://www.wenjiangs.com/docs/boost-c-zh
- 官方文档：https://www.boost.org/doc/libs/1_76_0/



## Git

### git config setting  

```shell
 git config --list
 git config --global user.email "[email address]"
 git config --global user.name "[name]"
```

### git代码开发流程  

```shell
 git clone project_address
 git checkout -b <new-branch-name>
 
 # 代码开发、bug修复等 
 
 git add .
 git commit -m "refactor: add related info"
 git push -u origin <new-branch-name>
 
 # git 界面操作：merge request，or Terminal
 git checkout master
 git merge hushaobao
 
```



### git删除分支  

```shell
 git branch -a                           # 查看项目的分支list  
 git branch -d <BranchName>              # 删除本地分支  
 git push origin --delete <BranchName>   # 删除远程分支  
 
```

### git merge

```shell
 '''
 git merge  # 没有参数
 即默认启用fast-forward方式进行合并，不会显示 feature，只保留单条分支记录。git直接把HEAD指针指向合并分支的头，完成合并。属于“快进方式”，不过这种情况如果删除分支，则会丢失分支信息。因为在这个过程中没有创建commit。
 
 git merge --squash
 用来把一些不必要commit进行压缩，比如说，你的feature在开发的时候写的commit很乱，那么我们合并的时候不希望把这些历史commit带过来，于是使用--squash进行合并，此时文件已经同合并后一样了，但不移动HEAD，不提交。需要进行一次额外的commit来“总结”一下，然后完成最终的合并。
 
 git merge --no-ff
 强行关闭fast-forward方式。可以保存你之前的分支历史。能够更好的查看 merge历史，以及branch 状态。
 '''
```

### git commmit  

```shell
 git commit -am = git add + git commit
 # 修改内容（代码以及description）后重新commit
 git commit --amend -m ""
```

### commit info and format  

```shell
 # format
 '''
 <type>(<scope>): <subject>
 // 空一行
 <body>
 // 空一行
 <footer>
 '''
 
 # example
 feat: add save function
 
 # detail
 # 1. Header: 只有一行，包括三个字段：type（必需）、scope（可选）和subject（必需）。
 '''
 type: 用于说明 commit 的类型。一般有以下几种:
     feat: 新增feature 
     fix: 修复bug 
     docs: 仅仅修改了文档，如readme.md 
     style: 仅仅是对格式进行修改，如逗号、缩进、空格等。不改变代码逻辑。 
     refactor: 代码重构，没有新增功能或修复bug 
     perf: 优化相关，如提升性能、用户体验等。 
     test: 测试用例，包括单元测试、集成测试。 
     chore: 改变构建流程、或者增加依赖库、工具等。 
     revert: 版本回滚
 scope: 用于说明 commit 影响的范围，比如: views, component, utils, test...
 subject: commit 目的的简短描述
 '''
 # 2. Body: 对本次 commit 修改内容的具体描述, 可以分为多行。如下所示:
 '''
 body: 72-character wrapped. This should answer:
 * Why was this change necessary?
 * How does it address the problem?
 * Are there any side effects?
 '''
 # 3. Footer:一些备注, 通常是 BREAKING CHANGE(当前代码与上一个版本不兼容) 或修复的 bug(关闭 Issue) 的链接。
```



### 查看/修改 用户名邮箱

```shell
 查看一下git的配置列表：
 
 git config --list
 
 1.查看用户名和邮箱地址
 
 git config user.name
 git config user.email
 
 
 2.修改全局用户名和邮箱地址：
 
 git config --global user.name  "username111"     
 git config --global user.email "email111"        
 
 
 3.修改局部用户名和邮箱地址:
 
 cd ~/you project                       
 git config user.name  "username111"      
 git config user.email "email111"     
```



### 代码撤销

```shell
# 软撤销 --soft 本地代码不会变化，只是 git 转改会恢复为 commit 之前的状态
# 不删除工作空间改动代码，撤销 commit，不撤销 git add .

git reset --soft HEAD~1

# 表示撤销最后一次的 commit ，1 可以换成其他更早的数字

# 硬撤销 本地代码会直接变更为指定的提交版本，慎用

# 删除工作空间改动代码，撤销 commit，撤销 git add .

# 注意完成这个操作后，就恢复到了上一次的commit状态。

git reset --hard HEAD~1

# 如果仅仅是 commit 的消息内容填错了 输入

git commit --amend

# 进入 vim 模式，对 message 进行更改

# 还有一个 --mixed

git reset --mixed HEAD~1

# 意思是：不删除工作空间改动代码，撤销commit，并且撤销git add . 操作 这个为默认参数,git reset --mixed HEAD~1 和 git reset HEAD~1 效果是一样的。

```

## GDB

### **GDB常用命令**

**使用gdb调试需编译为debug版本**

- cmake设置为Debug模式: -DCMAKE_BUILD_TYPE=Debug  
- Makefile: g++ -g -O0 src -o dst

```shell
 # GDB常用命令
 >>>gdb run_perception                         # 启用gdb调试
 >>>(gdb)set args config.json                  # 设置程序运行参数
 >>>(gdb)show args                             # 显示设置的参数
 
 >>>(gdb)b src/distance.cpp:120                # 设置断点
 >>>(gdb)info b                                # 查看断点
 
 >>>(gdb)p variable                            # 打印变量
 >>>(gdb)display variable                      # 显示变量
 >>>(gdb)display variable                      # 显示变量
 
 >>>(gdb)watch var/*p                          # 监视变量或内存，改变时中断
 
 >>>(gdb)n                                     # 执行下一行代码
 >>>(gdb)next N                                # 执行N次下一步
 >>>(gdb)c                                     # 继续执行程序
 
 >>>(gdb)delect display 1                      # 删除监视变量
 >>>(gdb)delect 1                              # 清除断点
 
 >>>(gdb)bt                                    # 查看堆栈信息
 
 >>>(gdb)q                                     # 退出gdb调试
 # display命令: 显示变量的值
 help display
 display var
 info display
 undisplay 1
 delete display 1
 disable display 1
 enable display 1
 
 # list命令：查看代码(l or list)
 set listsize 30                               # 设置显示30行，默认10行
 list src/distance.cpp:120
 
```

## CMake

```shell
 # CMake
 # https://zhuanlan.zhihu.com/p/93895403
 # http://wiki.calmcar.com:8090/pages/viewpage.action?pageId=83643656
 # CMake命令不区分大小写，变量区分
 
 
 # -D 定义参数
 -DCMAKE_BUILD_TYPE=Release/Debug  # 编译为release/debug版本
 
 # 增加编译选项
 add_compile_options(-Wall -Wextra -g)
 
 # 生成二进制文件run_perception
 add_executable(run_perception)
 
 # 添加头文件目录
 include_directories()
 
 # 添加链接库目录
 link_directories()
 
 # 设置要链接的库文件的名称
 target_link_libraries
```




## 挂载

```shell
 # sshfs
 # https://github.com/winfsp/sshfs-win
 sudo sshfs -o nonempty,allow_other,exec username@ip:/ mount_dir -p 10086
 
 # WSL中挂载win中的硬盘、移动硬盘、映射驱动等
 sudo mount -t drvfs Z:/data mount_dir
 
 # 挂载共享路径
 sudo mount -t cifs -o username=system,password=Apt123! -l //10.1.2.10/shared ./mount10
 
 # 挂载win共享路径
 # password可能是电脑账号邮箱密码
 sudo mount -t cifs -o username="calmcar",password="calmcar" //172.16.1.8/z_scp_tmp mount8
 
 # win
 # 根目录
 \\sshfs.r\username@remote_ip!port\
 
 # home 目录
 \\sshfs\username@remote_ip!port\
 # 或者：\\sshfs.r\username@remote_ip!port\home\username\
 
 
 #### linux挂载存在的问题
 # 1. mount ... failed: Permission denied
 1、sudo apt-get install nfs-kernel-server portmap
 2、sudo vim /etc/exports
 3、在 /etc/exports 中 加入 /home/zk/work/ *(rw,no_root_squash,no_all_squash)     # *代表所有的ip都可以mount
 4、sudo /etc/init.d/portmap restart
 5、sudo /etc/init.d/nfs-kernel-server restart
 
 # 2. 防火墙未关闭导致挂载错误
 mount error(115): Operation now in progress
 Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
 
 # 3. 重复挂载错误
 mount error(16): Device or resource busy
 Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
 # 则表示当前共享目录已经挂载上来了，先输入df命令确认是否已挂载
```





## 后台任务

### screen

### nohup

### Tmux

```shell
 # tmux
 # create session
 tmux 
 tmux new -s <session-name>
 # Ctrl+b d：分离当前会话。 同时按下ctrl+b，松开，再按下 d，即可正常挂起当前会话
 # Ctrl+b s：列出所有会话。
 # Ctrl+b $：重命名当前会话。
 tmux detach
 tmux ls
 tmux attach -t <session-name>
 tmux kill-session -t <session-name>
 
 # switch session
 tmux switch -t <session-name>
 # rename session
 tmux rename-session -t <old-session-name> <new-session-name>
 
 # split session windows
 # 切割窗格的快捷键 ctrl + b % 可以快速的左右切割，ctrl + b “ 可以快速的上下进行切割
 tmux split-window     # up/down
 tmux split-window -h  # left/right
 
```



## **WSL**

```shell
 
 # WSL win启动设置命令  --- 静态ip
 New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow
 ubuntu1804.exe run "echo 'calmcar' | sudo -S init_ubuntu"
 
 
 calmcar@LAPTOP-2QULSJSQ:~$ cat /bin/init_ubuntu
 #!/bin/bash
 
 # sudo rm /etc/resolv.conf
 # sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
 # sudo bash -c 'echo "[network]" > /etc/wsl.conf'
 # sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
 
 echo "sudo ifconfig eth0 172.24.240.111/20"
 sudo ifconfig eth0 172.24.240.111/20
 # sudo ifconfig eth0 172.24.240.111/20 broadcast 172.24.240.255
 
 echo "sudo ip route add 0.0.0.0/0 via 172.24.240.1 dev eth0"
 sudo ip route add 0.0.0.0/0 via 172.24.240.1 dev eth0
 
 echo "sudo service ssh start"
 sudo service ssh start
 
```

### 迁移

```shell
 wsl -l -v
 #   NAME            STATE           VERSION
 # * Ubuntu-18.04    Stopped         2
 wsl -t <DistributionName>
 
 wsl --export <DistributionName> <FileName.tar>
 # e.g.: wsl --export Ubuntu-18.04 D:\wsl\Ubuntu1804.tar
 wsl --unregister Ubuntu-18.04   # 注销原始子系统
 wsl --import <DistributionName> <InstallLocation> <FileName.tar> --version 2
 # e.g.: wsl --import Ubuntu D:\wsl\Ubuntu1804\ D:\wsl\Ubuntu1804.tar
 Ubuntu config --default-user {username}  # 可能不好使
 # 设置默认用户编辑或新增要修改的 Linux 子系统发行版中的 /etc/wsl.conf 文件，设置 default=用户名
 # 新增如下行,然后重启 Linux 子系统
```

 [user]
 default=<string>

 ```

 ```



## 网络相关

### 1. ip地址和子网掩码

ipv4：32位

子网掩码：子网掩码非0的位对应的ip上的数字表示这个ip的**网络位**，子网掩码0位对应的数字是ip的**主机位**。

两个ip间能否通信：网络位是否一致

```shell
 ping -c 3 172.25.254.172   # 只连接三次
 ping -w 1 172.25.254.172   # 只等待一秒机就返回能否通信的结果
```



### 2. 网络设定工具

#### ifconfig

```shell
 ifconfig    # 查看所有网络接口
 ifconfig eth0 查看eth0网卡详细信息
 
 # 这里的24=11111111.11111111.11111111.00000000=255.255.255.0
 ifconfig eth0 192.168.1.1/24  # 设定临时ip，ifconfig device ip/netmask
 ifconfig eth0 192.168.2.10 netmask 255.255.255.0 broadcast 192.168.2.255  # 配置网卡信息
 
 ifconfig eth0 down  # 关闭device eth0
 ifconfig eth0 up    # 开启device eth0
 
 ifconfig eth0 hw ether AA:AA:BB:CC:dd:EE  # 用ifconfig修改网卡eth0 MAC地址
 
 ifconfig eth0 arp    # 开启网卡eth0的arp协议
 ifconfig eth0 -arp   # 关闭网卡eth0的arp协议
```

#### ip

```shell
 # ip命令
 
 ip link show # 显示网络接口信息
 
 ip link set eth0 up # 开启网卡
 ip link set eth0 down # 关闭网卡
 
 ip link set eth0 promisc on # 开启网卡的混合模式
 ip link set eth0 promisc offi # 关闭网卡的混个模式
 
 ip link set eth0 txqueuelen 1200 # 设置网卡队列长度
 ip link set eth0 mtu 1400 # 设置网卡最大传输单元
 
 ip addr show # 显示网卡IP信息
 ip addr flush eth0  # 删除网卡eth0上的所有ip
 ip addr add 192.168.0.1/24 dev eth0 # 设置eth0网卡IP地址192.168.0.1
 ip addr del 192.168.0.1/24 dev eth0 # 删除eth0网卡IP地址
 
 ip route show # 显示系统路由
 ip route add default via 192.168.1.254 # 设置系统默认路由
 ip route list # 查看路由信息
 ip route add 192.168.4.0/24 via 192.168.0.254 dev eth0 # 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口
 
 ip route add default via 192.168.0.254 dev eth0 # 设置默认网关为192.168.0.254
 ip route del 192.168.4.0/24 # 删除192.168.4.0网段的网关
 ip route del default # 删除默认路由
 
 ip route delete 192.168.1.0/24 dev eth0 # 删除路由
 
```



#### 永久设定网络接口

- 前台图形界面设定

```shell
 nm-connection-editor  # 使用需安装sudo apt install network-manager-gnome
```

- 后台图形界面设定

```shell
 nmtui                 # 使用需安装sudo apt install network-manager
```

- nmcli命令设定

```shell
 systemctl status NetworkManager  # 必须先开启NetworkManager
 
 nmcli device show eth0      # 查看eth0网卡信息
 nmcli device status eth0    # 查看网卡服务接口信息
 
 nmcli device connect eth0     # 启用eth0网关
 nmcli device disconnect eth0  # 关闭eth0网关
 
 nmcli connection show           # 显示所有网络链接
 nmcli connection down westos    # 关闭指定网络链接
 nmcli connection up westos      # 开启指定网络链接
 nmcli connection delete westos  # 删除指定网络链接
 
 nmcli connection add type ethernet con-name westos ifname eth0 ip4 172.25.254.100/24     # 添加网络链接
 nmcli connection modify westos ipv4.method auto                      # 将westos链接改为动态网络
 nmcli connection modify westos ipv4.method manual                    # 将westos链接改为静态网络
 nmcli connection modify westos ipv4.addrresses 172.25.254.200/24     # 修改westos链接的网络ip
```



- 网络配置文件



## **FFmpeg**常用命令



```shell
#  相关链接：
#  http://www.imooc.com/article/details/id/254520
#  https://www.cnblogs.com/dch0/p/11149266.html
 
 # 1.视频转图片:
 
 ffmpeg -i 1.mp4 -r 5 -f image2 ./output/1_frame_%05d.bmp
 
 # "-r 5"代表一秒中抽取五帧
 # -f: fmt(force format)
 # "image2"代表图片的类型，
 # "%05d"代表五位的数，如“00001”
 # 输出图片的后缀不一定要为bmp，也可以为png，这都是无损提取。而输出的图片为jpg时，输出的图片就是压缩过后的。
 
 
 # 2.图片转视频：
 
 ffmpeg -f image2 -framerate 25 -start_number 1 -i "img%05d.bmp" -b:v 25313k ./output/222.mp4
 # "-framerate 25": 代表一秒25帧，
 # "-b:v 25313k": 代表视频所需的码率为25313k
 # 码率的获取：利用ffmpeg将视频变为图片完成的时候，会得到bitrate
 # 可以通过 -start_number 指定起始图像序号
 
# 视频转gif
 
 ffmpeg -i out.mp4 -ss 00:00:00 -r 25 -t 10 out.gif

 # 3.抽取音频流
 
 ffmpeg -i input.mp4 -acodec copy -vn out.aac
 # acodec: 指定音频编码器，copy 指明只拷贝，不做编解码。
 # vn: v 代表视频，n 代表 no 也就是无视频的意思
 
 
 # 4.抽取视频流
 ffmpeg -i input.mp4 -vcodec copy -an out.h264
 # vcodec: 指定视频编码器，copy 指明只拷贝，不做编解码。
 # an: a 代表视频，n 代表 no 也就是无音频的意思。
 
 # 5.转格式
 
 ffmpeg -i out.mp4 -vcodec copy -acodec copy out.flv
 # 上面的命令表式的是音频、视频都直接 copy，只是将 mp4 的封装格式转成了flv。
 
 
 # 6.提取YUV数据
 
 ffmpeg -i input.mp4 -an -c:v rawvideo -pixel_format yuv420p out.yuv
 ffplay -s wxh out.yuv
 # -c:v rawvideo 指定将视频转成原始数据
 # -pixel_format yuv420p 指定转换格式为yuv420p
 
 # 7.YUV转H264
 
 ffmpeg -f rawvideo -pix_fmt yuv420p -s 320x240 -r 30 -i out.yuv -c:v libx264 -f rawvideo out.h264
 
 # 8.提取PCM数据
 
 ffmpeg -i out.mp4 -vn -ar 44100 -ac 2 -f s16le out.pcm
 ffplay -ar 44100 -ac 2 -f s16le -i out.pcm
 
 # 9.PCM转WAV
 
 ffmpeg -f s16be -ar 8000 -ac 2 -acodec pcm_s16be -i input.raw output.wav
 
 
 # 10.添加水印
 
 ffmpeg -i out.mp4  -vf "movie=logo.png,scale=64:48[watermask];[in][watermask] overlay=30:10 [out]" water.mp4
 # -vf中的 movie 指定logo位置。scale 指定 logo 大小。overlay 指定 logo 摆放的位置。
 # 删除水印
 # 先通过 ffplay 找到要删除 LOGO 的位置
 ffplay -i test.flv -vf delogo=x=806:y=20:w=70:h=80:show=1
 
 # 11.使用 delogo 滤镜删除 LOGO
 
 ffmpeg -i test.flv -vf delogo=x=806:y=20:w=70:h=80 output.flv
 
 # 12.视频缩小一倍
 
 ffmpeg -i out.mp4 -vf scale=iw/2:-1 scale.mp4
 # -vf scale 指定使用简单过滤器 scale，iw/2:-1 中的 iw 指定按整型取视频的宽度。 -1 表示高度随宽度一起变化。
 
 # 13.视频裁剪
 
 ffmpeg -i VR.mov  -vf crop=in_w-200:in_h-200 -c:v libx264 -c:a copy -video_size 1280x720 vr_new.mp4
 # crop 格式：crop=out_w:out_h: x :y
 
 # out_w: 输出的宽度。可以使用 in_w 表式输入视频的宽度。
 # out_h: 输出的高度。可以使用 in_h 表式输入视频的高度。
 # x : X坐标
 # y : Y坐标
 # 如果 x和y 设置为 0,说明从左上角开始裁剪。如果不写是从中心点裁剪。
 
 # 14.倍速播放
 
 ffmpeg -i out.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" speed2.0.mp4
 # -filter_complex 复杂滤镜，[0:v]表示第一个（文件索引号是0）文件的视频作为输入。setpts=0.5*PTS表示每帧视频的pts时间戳都乘0.5 ，也就是差少一半。[v]表示输出的别名。音频同理就不详述了。
 # map 可用于处理复杂输出，如可以将指定的多路流输出到一个输出文件，也可以指定输出到多个文件。"[v]" 复杂滤镜输出的别名作为输出文件的一路流。上面 map的用法是将复杂滤镜输出的视频和音频输出到指定文件中。
 
 # 15.对称视频
 
 ffmpeg  -i out.mp4 -filter_complex "[0:v]pad=w=2*iw[a];[0:v]hflip[b];[a][b]overlay=x=w" duicheng.mp4
 
 # 16.hflip 水平翻转
 # 如果要修改为垂直翻转可以用vflip。
 
 # 17.画中画
 
 ffmpeg -i out.mp4 -i out1.mp4 -filter_complex "[1:v]scale=w=176:h=144:force_original_aspect_ratio=decrease[ckout];[0:v][ckout]overlay=x=W-w-10:y=0[out]" -map "[out]" -movflags faststart new.mp4
 
 # 18. 录制画中画
 
 ffmpeg  -f avfoundation -i "1" -framerate 30 -f avfoundation -i "0:0" 
 -r 30 -c:v libx264 -preset ultrafast 
 -c:a libfdk_aac -profile:a aac_he_v2 -ar 44100 -ac 2 
 -filter_complex "[1:v]scale=w=176:h=144:force_original_aspect_ratio=decrease[a];[0:v][a]overlay=x=W-w-10:y=0[out]" 
 -map "[out]" -movflags faststart -map 1:a b.mp4
 
 # 19.多路视频拼接
 
 ffmpeg  -f avfoundation -i "1" -framerate 30 -f avfoundation   -i "0:0" -r 30 -c:v libx264 -preset ultrafast -c:a libfdk_aac -profile:a aac_he_v2 -ar 44100 -ac 2 -filter_complex "[0:v]scale=320:240[a];[a]pad=640:240[b];[b][1:v]overlay=320:0[out]" -map "[out]" -movflags faststart  -map 1:a  c.mp4
 
 # 20.滤镜加水印
 
 ffmpeg -i killer.mp4 -filter_complex "movie=./logo/daka.png,scale=64:48[w];[0:v]curves=vintage[o];[o][w]overlay=30:10[out]" -map "[out]" -map 0:a test1.mp4
 
 
 
 #### 音视频裁剪
 
 # 1. 裁剪
 ffmpeg -i out.mp4 -ss 00:00:00 -t 10 out1.mp4
 # -ss 指定裁剪的开始时间，精确到秒
 # -t 被裁剪后的时长。
 
 # 2. 视频合并
 ffmpeg -f concat -i inputs.txt -c copy output.flv

 """inputs.txt
 file '1.flv'
 file '2.flv'
 file '3.flv'
 """
 
 
 # 3. 音频合并
 
 ffmpeg -i text.mp3 -i silenceall.mp3 -filter_complex '[0:0] [1:0] concat=n=2:v=0:a=1 [a]' -map [a] test.mp3
 
 # 4. 音频混音
 
 ffmpeg -i test.mp4 -i test.mp3 -filter_complex "[0:a] [1:a]amerge=inputs=2[aout]" -map "[aout]" -ac 2 mix_amerge.aac
 # 或
 ffmpeg -i INPUT1 -i INPUT2 -i INPUT3 -filter_complex 'amix=inputs=3:duration=first:dropout_transition=3' OUTPUT

 inputs: The number of inputs. If unspecified, it defaults to 2.//输入的数量，如果没有指明，默认为2.
 duration: How to determine the end-of-stream.//决定了流的结束
 longest: The duration of the longest input. (default)//最长输入的持续时间
 shortest: The duration of the shortest input.//最短输入的持续时间
 first: The duration of the first input.//第一个输入的持续时间
 dropout_transition: The transition time, in seconds, for volume renormalization when an input stream ends. The default value is 2 seconds.//输入流结束时（音频）容量重整化的转换时间（以秒为单位）。 默认值为2秒。
 注： amerge 与amix 的区别
 amerge terminates with the shortest input (always) and amix terminates with the longest input, by default. So the former will always truncate when streams are of different length.


 ##直播相关
 
 # 1. 推流
 
 ffmpeg -re -i out.mp4 -c copy -f flv rtmp://server/live/streamName
 
 # 2. 拉流保存
 
 ffmpeg -i rtmp://server/live/streamName -c copy dump.flv
 
 # 3. 转流
 
 ffmpeg -i rtmp://server/live/originalStream -c:a copy -c:v copy -f flv rtmp://server/live/h264Stream
 
 # 4. 实时推流
 
 ffmpeg -framerate 15 -f avfoundation -i "1" -s 1280x720 -c:v libx264  -f  flv rtmp://localhost:1935/live/room
 
 
 #### ffplay
 
 # 1. 播放YUV 数据
 
 ffplay -pix_fmt nv12 -s 192x144 1.yuv
 
 # 2. 播放YUV中的 Y平面
 
 ffplay -pix_fmt nv21 -s 640x480 -vf extractplanes='y' 1.yuv
```
