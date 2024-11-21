#!/bin/bash

docker pull --platform arm64 alpine:3

docker pull --platform arm64 centos:7
docker pull --platform arm64 centos:8

docker pull --platform arm64 debian:bookworm
docker pull --platform arm64 debian:bookworm-slim

docker pull --platform arm64 ubuntu:noble

docker pull --platform arm64 eclipse-temurin:8-jdk-noble
docker pull --platform arm64 eclipse-temurin:8-jre-noble
docker pull --platform arm64 eclipse-temurin:21-jre-noble

docker pull --platform amd64 gitlab/gitlab-ce:latest
docker pull --platform arm64 gitlab/gitlab-runner:alpine

docker pull --platform arm64 golang:1.12-alpine

docker pull --platform arm64 jenkins/jenkins:lts-alpine-jdk21
docker pull --platform arm64 jenkins/inbound-agent:alpine-jdk21
docker pull --platform arm64 jenkins/agent:alpine-jdk21

docker pull --platform amd64 mysql:5-debian
docker pull --platform arm64 mysql:8

docker pull --platform arm64 nginx:stable-alpine-slim

docker pull --platform arm64 node:14-alpine

docker pull --platform amd64 osixia/keepalived:latest

docker pull --platform arm64 redis:7-alpine

docker pull --platform arm64 registry:2

docker pull --platform arm64 tomcat:9-jre8-temurin-noble

