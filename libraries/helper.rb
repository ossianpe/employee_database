module EmployeeDatabase
    module Helper
        def init_mysql_connection(db_name, mysql_usr, mysql_pw)
            init_connection="mysql \
                --socket=/var/run/mysql-#{db_name}/mysqld.sock \
                --user=#{mysql_usr} \
                --password=#{mysql_pw}"
        end

        def init_remote_mysql_connection(hostname, remote_mysql_usr, remote_mysql_pw)
            init_connection="mysql \
                --host=#{hostname} \
                --user=#{remote_mysql_usr} \
                --password=#{remote_mysql_pw}"
        end
    end
end

::Chef::Recipe.send(:include, EmployeeDatabase::Helper)