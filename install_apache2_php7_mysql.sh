#!/bin/bash

alias apache2_php='apt install -y apache2 php7.0 libapache2-mod-php7.0'
alias reiniciar='service apache2 restart'
alias phpmyadmin='apt install -y phpmyadmin'
# alias mysql definido no case, alterando de acordo com parâmentro do programa

# tratamento de parâmetros
case $1 in
    '-h') echo 'Instalador de Apache2, MySQL/MariaDB(default) e php7'
          echo 'Sintaxe:' $0 '[-h --mysql]'
          echo ' -h         Ajuda'
          echo ' --mysql    Instala MySQL no lugar de MariaDB'
          exit 1;;
    '--mysql') alias mysql='apt install -y mysql-server mysql-client php7.0-mysql';;
    *) alias mysql='apt install -y mariadb-server mariadb-client php7.0-mysql';;
esac

# verifica se o programa está sendo executado pelo ROOT("0")
if [ "$(id -u)" != "0" ]; then
    echo 'Execute esse programa como ROOT'
else
    echo "Iniciar instalação (S/n)? " 
    read CONFIRMACAO 

    case $CONFIRMACAO in
        s|S|y|Y )
                if apache2_php && reiniciar && mysql && phpmyadmin; then

                    # adicionando acesso ao phpmyadmin no apache
                    CONF="/etc/phpmyadmin/apache.conf"
                    ARQ="/etc/apache2/sites-enabled/000-default.conf"
                    
                    # Se não existe a entrada CONF no arquivo ARQ,
                    # incrementa uma nova linha com Include e conteúdo de CONF.
                    if ! grep -q $CONF $ARQ; then
                        echo "Include" $CONF >> $ARQ   
                    fi
                    
                    reiniciar
                    xdg-open 'http://localhost/phpmyadmin' &

                fi;;
        *) echo 'Cancelando instalação';;
    esac

fi

echo "No final desse arquivo contém instruções para correções em possíveis erros"

# alterar diretório(padrão) da pasta www do apache
# alterar arquivos /etc/apache2/apache2.conf
    # alterar linha:
    # <Directory /var/www/>
    # para:
    # <Directory /home/usuario/novo_diretorio/>
    #     Options Indexes FollowSymLinks
    #     AllowOverride All
    #     Require all granted
    # </Directory>
# crie(como root) o novo_diretorio na pasta informada
# e /etc/apache2/sites-available/000-default.conf
    # alterar linha:
    # DocumentRoot /var/www
    # para:
    # DocumentRoot /home/usuario/novo_diretorio/
# resetar servico apache2
    # sudo service apache2 restart

# Corrigir acesso negado no phpmyadmin para usuário root
#   mysql> GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'SENHA' WITH GRANT OPTION;
#   mysql> GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'SENHA' WITH GRANT OPTION;
#   mysql> GRANT ALL ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'SENHA' WITH GRANT OPTION;

# RESETAR SENHA DO ROOT
#   sudo service mysql stop
#   sudo mysqld_safe --skip-grant-tables &  # iniciar o servico em modo de segurança
#   sudo mysql  # ou # sudo mysql -u root
#   mysql> use mysql;
#   mysql> update user SET password=password('NOVA SENHA') WHERE user='root';
#   mysql> quit;
#   sudo service mysql restart

# ATIVAR ACESSO REMOTO PARA O MYSQL/MARIADB
#   sudo vim /etc/mysql/my.cnf
# alterar bind-address = 127.0.0.1 para:
#   bind-address = 0.0.0.0
#   sudo /etc/init.d/mysql restart  # reiniciando mysql
# entrar no mysql e redefinir permissões para o root
#   mysql -uroot -pSENHA
#   mysql> GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'SENHA' WITH GRANT OPTION;
# para definir para um usuário(deve existir) ou host específico:
#   mysql> GRANT ALL ON *.* TO 'usuario'@'hostOuIpMaquina' IDENTIFIED BY 'SENHA' WITH GRANT OPTION; # pode substituir *.* pelo banco específico.
# APÓS definir permissões, executar:
#   mysql> FLUSH PRIVILEGES;

