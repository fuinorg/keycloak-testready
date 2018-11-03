FROM jboss/keycloak:4.5.0.Final
MAINTAINER Michael Schnell

ENV IMPORT_JSON ""

USER root

ADD testready-entrypoint.sh /opt/jboss/
RUN ["chown", "jboss:jboss", "/opt/jboss/testready-entrypoint.sh"]
RUN ["chmod", "+x", "/opt/jboss/testready-entrypoint.sh"]

ENTRYPOINT [ "/opt/jboss/testready-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
