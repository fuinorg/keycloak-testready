FROM jboss/keycloak:9.0.3
MAINTAINER Michael Schnell

ENV IMPORT_JSON ""

USER root

ADD testready-entrypoint.sh /opt/jboss/
RUN ["chown", "jboss:jboss", "/opt/jboss/testready-entrypoint.sh"]
RUN ["chmod", "+x", "/opt/jboss/testready-entrypoint.sh"]

ENTRYPOINT [ "/opt/jboss/testready-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
