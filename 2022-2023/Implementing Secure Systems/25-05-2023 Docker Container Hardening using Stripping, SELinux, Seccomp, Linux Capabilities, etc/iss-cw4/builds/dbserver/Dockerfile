# Database Dockerfile

FROM mariadb:10

# Copy the supplied mysql configuration file to container.
COPY configfiles/mysqld.cnf	/mysql/mysql.conf.d/mysqld.cnf

# Define entrypoint for container and the parameter(s).
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["mysqld"]

# Specify which port the container listens on.
EXPOSE 3306

