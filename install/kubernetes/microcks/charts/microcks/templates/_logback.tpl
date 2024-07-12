{{/*
Generate the logback.xml content
*/}}
{{- define "logback-xml" -}}
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true">
  <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
    <encoder>
      <charset>utf-8</charset>
      <Pattern>%d{HH:mm:ss.SSS} [%p] %c - %m%n</Pattern>
    </encoder>
  </appender>
  <logger name="io.github.microcks" level="{{ .Values.microcks.logLevel }}"/>
  <!-- Change com.mongodb to org.mongodb so that com.mongodb.FongoDBCollection is ignored, set to debug and tests do not fail... -->
  <logger name="org.mongodb" level="INFO"/>
  <logger name="org.springframework.data.mongodb" level="INFO"/>
  <logger name="org.reflections" level="WARN"/>
  <logger name="sun.net.www.protocol.http" level="INFO"/>
  <logger name="jdk.event.security" level="WARN"/>
  <logger name="javax.activation" level="WARN"/>
  <logger name="javax.mail" level="WARN"/>
  <logger name="javax.xml.bind" level="WARN"/>
  <logger name="ch.qos.logback" level="WARN"/>
  <logger name="com.codahale.metrics" level="WARN"/>
  <logger name="com.ryantenney" level="WARN"/>
  <logger name="com.sun.xml.internal.bind" level="WARN"/>
  <logger name="com.zaxxer" level="WARN"/>
  <logger name="io.undertow" level="WARN"/>
  <logger name="org.apache" level="WARN"/>
  <logger name="org.apache.catalina.startup.DigesterFactory" level="OFF"/>
  <logger name="org.bson" level="WARN"/>
  <logger name="org.hibernate.validator" level="WARN"/>
  <logger name="org.hibernate" level="WARN"/>
  <logger name="org.hibernate.ejb.HibernatePersistence" level="OFF"/>
  <logger name="org.springframework" level="WARN"/>
  <logger name="org.springframework.aop" level="WARN"/>
  <logger name="org.springframework.web" level="WARN"/>
  <logger name="org.springframework.security" level="WARN"/>
  <logger name="org.springframework.cache" level="WARN"/>
  <logger name="org.springframework.scheduling" level="WARN"/>
  <logger name="org.thymeleaf" level="WARN"/>
  <logger name="org.xnio" level="WARN"/>
  <logger name="com.mangofactory.swagger" level="WARN"/>
  <logger name="sun.rmi.transport" level="WARN"/>
  <contextListener class="ch.qos.logback.classic.jul.LevelChangePropagator">
    <resetJUL>true</resetJUL>
  </contextListener>
  <root level="INFO">
    <appender-ref ref="CONSOLE"/>
  </root>
</configuration>
{{- end }}