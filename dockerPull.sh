#!/bin/bash

docker pull alpine:3

docker pull centos:7
docker pull centos:8

docker pull debian:bookworm
docker pull debian:bookworm-slim

docker pull ubuntu:noble

docker pull eclipse-temurin:8-jdk-noble
docker pull eclipse-temurin:8-jre-noble
docker pull eclipse-temurin:21-jre-noble

# docker pull gitlab/gitlab-ce:latest
docker pull gitlab/gitlab-runner:alpine

docker pull golang:1.12-alpine

docker pull jenkins/jenkins:lts-alpine-jdk21
docker pull jenkins/inbound-agent:alpine-jdk21
docker pull jenkins/agent:alpine-jdk21

docker pull mysql:8

docker pull nginx:stable-alpine-slim

docker pull node:14-alpine

docker pull osixia/keepalived:latest

docker pull redis:7-alpine

docker pull registry:2

docker pull tomcat:9-jre8-temurin-noble
