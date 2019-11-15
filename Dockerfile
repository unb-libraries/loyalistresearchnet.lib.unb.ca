FROM unblibraries/drupal:8.x-1.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

LABEL name="loyalistresearchnet.org"
LABEL vcs-ref=""
LABEL vcs-url="https://github.com/unb-libraries/loyalistresearchnet.org"

ENV DRUPAL_SITE_ID loyaltres
ENV DRUPAL_SITE_URI loyalistresearchnet.org
ENV DRUPAL_SITE_UUID 4f7e5705-9fb7-4e1b-a2fe-032e04e64e9a

# Deploy upstream scripts, and then override with any local.
RUN curl -sSL https://raw.githubusercontent.com/unb-libraries/CargoDock/drupal-8.x-1.x/container/deploy.sh | sh
COPY ./scripts/container /scripts

# Add additional OS packages.
ENV ADDITIONAL_OS_PACKAGES rsyslog postfix php7-ldap
RUN /scripts/addOsPackages.sh && \
  echo "TLS_REQCERT never" > /etc/openldap/ldap.conf && \
  /scripts/initRsyslog.sh

# Add package conf.
COPY ./package-conf /package-conf
RUN /scripts/setupStandardConf.sh

# Build the contrib Drupal tree.
ARG COMPOSER_DEPLOY_DEV=no-dev
ENV DRUPAL_BASE_PROFILE minimal
ENV DRUPAL_BUILD_TMPROOT ${TMP_DRUPAL_BUILD_DIR}/webroot

COPY ./build/ ${TMP_DRUPAL_BUILD_DIR}
RUN /scripts/build.sh ${COMPOSER_DEPLOY_DEV} ${DRUPAL_BASE_PROFILE}

# Deploy repo assets.
COPY ./tests/ ${DRUPAL_TESTING_ROOT}/
COPY ./config-yml ${TMP_DRUPAL_BUILD_DIR}/config-yml
COPY ./custom/themes ${TMP_DRUPAL_BUILD_DIR}/custom_themes
COPY ./custom/modules ${TMP_DRUPAL_BUILD_DIR}/custom_modules

# Universal environment variables.
ENV DEPLOY_ENV prod
ENV DRUPAL_DEPLOY_CONFIGURATION TRUE
ENV DRUPAL_CONFIGURATION_EXPORT_SKIP devel
