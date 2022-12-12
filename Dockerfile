# syntax=docker/dockerfile:1
FROM zshusers/zsh:latest

ARG user=nonroot

RUN <<-eot zsh
	apt update
	apt install -y git curl

	apt clean
	rm -rf /var/lib/apt/lists/*

	useradd $user -s /usr/bin/zsh --create-home
eot


WORKDIR /home/$user

COPY ./test/* ./
RUN chown $user:$user ./setup_pm.zsh ./test.zsh

USER $user

ENV PLUGIN_MGR=zi-zinit
RUN ./setup_pm.zsh

ENTRYPOINT ["./test.zsh"]
CMD ["as-entrypoint"]
