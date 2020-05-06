# code-dev
这是一个基于code_server的开发环境，开箱即用。
目前预装golang、python插件。

替换阿里源

alpine:

	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf


ubuntu

   echo deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse  > /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse  >> /etc/apt/sources.list &&\
   echo deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse  >> /etc/apt/sources.list &&\
   mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf &&\
