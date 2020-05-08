# code-dev
这是一个基于code_server的开发环境，开箱即用。

运行

	docker run -td --restart=always --name code --net xxx --privileged -p 8080:8080 -u root -v "xxx:/home/project" xingzhao0401/code-dev



替换阿里源

	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	mkdir /root/.pip/ && echo [global]>/root/.pip/pip.conf && echo index-url = https://mirrors.aliyun.com/pypi/simple >> /root/.pip/pip.conf



v1.0:预装golang、python插件。

