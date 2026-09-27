# Image du serveur Voyaj CRM (binaire AOT sur image minimale).
# Construction depuis la racine du dépôt :
#   docker build -f deploy/docker/Dockerfile -t voyaj/server .

FROM dart:3.13 AS build
WORKDIR /src
COPY . .
# Le client Flutter ne fait pas partie de l'image : on le retire du workspace
# (le SDK Dart seul ne sait pas résoudre les dépendances Flutter).
RUN sed -i '/- apps\/client/d' pubspec.yaml \
 && dart pub get \
 && mkdir -p /out \
 && dart compile exe apps/server/bin/voyaj_server.dart -o /out/voyaj_server

FROM scratch
# Bibliothèques système minimales et certificats racine fournis par l'image Dart.
COPY --from=build /runtime/ /
COPY --from=build /out/voyaj_server /app/voyaj_server
WORKDIR /app
USER 10001:10001
EXPOSE 8080
ENTRYPOINT ["/app/voyaj_server"]
CMD ["serve"]
