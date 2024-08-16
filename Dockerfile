FROM snowdreamtech/php:fpm-8.1.29-nginx-1.26.1

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV WORDPRESS_VERSION=6.6.1 \
    WORDPRESS_DB_NAME='test' \
    WORDPRESS_DB_USER='root' \
    WORDPRESS_DB_PASSWORD='' \
    WORDPRESS_DB_HOST='mariadb' \
    WORDPRESS_DB_CHARSET='utf8mb4' \
    WORDPRESS_DB_COLLATE='utf8mb4_unicode_ci' \
    WORDPRESS_AUTH_KEY='' \
    WORDPRESS_SECURE_AUTH_KEY='' \
    WORDPRESS_LOGGED_IN_KEY='' \
    WORDPRESS_NONCE_KEY='' \
    WORDPRESS_AUTH_SALT='' \
    WORDPRESS_SECURE_AUTH_SALT='' \
    WORDPRESS_LOGGED_IN_SALT='' \
    WORDPRESS_NONCE_SALT='' \
    WORDPRESS_TABLE_PREFIX='wp_' \
    WORDPRESS_DEBUG=0 \
    WORDPRESS_LANGUAGES_PATH=/var/lib/nginx/html/wp-content/languages 

RUN wget -c https://github.com/WordPress/WordPress/archive/refs/tags/${WORDPRESS_VERSION}.tar.gz \
    && tar zxvf ${WORDPRESS_VERSION}.tar.gz \
    && cp -rfv WordPress-${WORDPRESS_VERSION}/* /var/lib/nginx/html \
    && rm -rfv ${WORDPRESS_VERSION}.tar.gz \
    && rm -rfv WordPress-${WORDPRESS_VERSION} \
    && mkdir -p ${WORDPRESS_LANGUAGES_PATH} \
    && wget -c https://nl.wordpress.org/wordpress-${WORDPRESS_VERSION}-nl_NL.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-nl_NL.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-nl_NL.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://nl-be.wordpress.org/wordpress-${WORDPRESS_VERSION}-nl_BE.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-nl_BE.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-nl_BE.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://en-gb.wordpress.org/wordpress-${WORDPRESS_VERSION}-en_GB.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-en_GB.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-en_GB.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://gl.wordpress.org/wordpress-${WORDPRESS_VERSION}-gl_ES.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-gl_ES.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-gl_ES.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://de.wordpress.org/wordpress-${WORDPRESS_VERSION}-de_DE.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-de_DE.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-de_DE.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://de-at.wordpress.org/wordpress-${WORDPRESS_VERSION}-de_AT.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-de_AT.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-de_AT.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://it.wordpress.org/wordpress-${WORDPRESS_VERSION}-it_IT.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-it_IT.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-it_IT.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ja.wordpress.org/wordpress-${WORDPRESS_VERSION}-ja.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ja.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ja.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ko.wordpress.org/wordpress-${WORDPRESS_VERSION}-ko_KR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ko_KR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ko_KR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ku.wordpress.org/wordpress-${WORDPRESS_VERSION}-ckb.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ckb.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ckb.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://pt.wordpress.org/wordpress-${WORDPRESS_VERSION}-pt_PT.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-pt_PT.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-pt_PT.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ro.wordpress.org/wordpress-${WORDPRESS_VERSION}-ro_RO.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ro_RO.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ro_RO.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ru.wordpress.org/wordpress-${WORDPRESS_VERSION}-ru_RU.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ru_RU.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ru_RU.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://cl.wordpress.org/wordpress-${WORDPRESS_VERSION}-es_CL.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-es_CL.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-es_CL.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://es-mx.wordpress.org/wordpress-${WORDPRESS_VERSION}-es_MX.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-es_MX.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-es_MX.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://es.wordpress.org/wordpress-${WORDPRESS_VERSION}-es_ES.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-es_ES.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-es_ES.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://sv.wordpress.org/wordpress-${WORDPRESS_VERSION}-sv_SE.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-sv_SE.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-sv_SE.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://tr.wordpress.org/wordpress-${WORDPRESS_VERSION}-tr_TR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-tr_TR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-tr_TR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://vi.wordpress.org/wordpress-${WORDPRESS_VERSION}-vi.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-vi.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-vi.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://cy.wordpress.org/wordpress-${WORDPRESS_VERSION}-cy.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-cy.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-cy.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://sq.wordpress.org/wordpress-${WORDPRESS_VERSION}-sq.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-sq.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-sq.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://bg.wordpress.org/wordpress-${WORDPRESS_VERSION}-bg_BG.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-bg_BG.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-bg_BG.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://cn.wordpress.org/wordpress-${WORDPRESS_VERSION}-zh_CN.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-zh_CN.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-zh_CN.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://tw.wordpress.org/wordpress-${WORDPRESS_VERSION}-zh_TW.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-zh_TW.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-zh_TW.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://hr.wordpress.org/wordpress-${WORDPRESS_VERSION}-hr.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-hr.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-hr.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://cs.wordpress.org/wordpress-${WORDPRESS_VERSION}-cs_CZ.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-cs_CZ.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-cs_CZ.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://da.wordpress.org/wordpress-${WORDPRESS_VERSION}-da_DK.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-da_DK.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-da_DK.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://en-au.wordpress.org/wordpress-${WORDPRESS_VERSION}-en_AU.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-en_AU.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-en_AU.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://en-ca.wordpress.org/wordpress-${WORDPRESS_VERSION}-en_CA.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-en_CA.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-en_CA.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://en-nz.wordpress.org/wordpress-${WORDPRESS_VERSION}-en_NZ.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-en_NZ.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-en_NZ.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://en-za.wordpress.org/wordpress-${WORDPRESS_VERSION}-en_ZA.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-en_ZA.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-en_ZA.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://eo.wordpress.org/wordpress-${WORDPRESS_VERSION}-eo.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-eo.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-eo.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://fi.wordpress.org/wordpress-${WORDPRESS_VERSION}-fi.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-fi.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-fi.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://fr-ca.wordpress.org/wordpress-${WORDPRESS_VERSION}-fr_CA.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-fr_CA.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-fr_CA.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://fr.wordpress.org/wordpress-${WORDPRESS_VERSION}-fr_FR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-fr_FR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-fr_FR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ka.wordpress.org/wordpress-${WORDPRESS_VERSION}-ka_GE.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ka_GE.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ka_GE.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://de-ch.wordpress.org/wordpress-${WORDPRESS_VERSION}-de_CH.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-de_CH.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-de_CH.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://el.wordpress.org/wordpress-${WORDPRESS_VERSION}-el.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-el.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-el.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://hu.wordpress.org/wordpress-${WORDPRESS_VERSION}-hu_HU.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-hu_HU.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-hu_HU.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://id.wordpress.org/wordpress-${WORDPRESS_VERSION}-id_ID.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-id_ID.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-id_ID.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://kir.wordpress.org/wordpress-${WORDPRESS_VERSION}-kir.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-kir.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-kir.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://lv.wordpress.org/wordpress-${WORDPRESS_VERSION}-lv.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-lv.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-lv.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://mr.wordpress.org/wordpress-${WORDPRESS_VERSION}-mr.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-mr.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-mr.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ne.wordpress.org/wordpress-${WORDPRESS_VERSION}-ne_NP.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ne_NP.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ne_NP.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://nb.wordpress.org/wordpress-${WORDPRESS_VERSION}-nb_NO.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-nb_NO.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-nb_NO.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://fa.wordpress.org/wordpress-${WORDPRESS_VERSION}-fa_IR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-fa_IR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-fa_IR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://fa-af.wordpress.org/wordpress-${WORDPRESS_VERSION}-fa_AF.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-fa_AF.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-fa_AF.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://pl.wordpress.org/wordpress-${WORDPRESS_VERSION}-pl_PL.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-pl_PL.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-pl_PL.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://br.wordpress.org/wordpress-${WORDPRESS_VERSION}-pt_BR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-pt_BR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-pt_BR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://sk.wordpress.org/wordpress-${WORDPRESS_VERSION}-sk_SK.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-sk_SK.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-sk_SK.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://sl.wordpress.org/wordpress-${WORDPRESS_VERSION}-sl_SI.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-sl_SI.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-sl_SI.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://es-ar.wordpress.org/wordpress-${WORDPRESS_VERSION}-es_AR.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-es_AR.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-es_AR.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://es-co.wordpress.org/wordpress-${WORDPRESS_VERSION}-es_CO.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-es_CO.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-es_CO.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://sw.wordpress.org/wordpress-${WORDPRESS_VERSION}-sw.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-sw.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-sw.tar.gz \
    && rm -rfv wordpress \
    && wget -c https://ug.wordpress.org/wordpress-${WORDPRESS_VERSION}-ug_CN.tar.gz \
    && tar zxvf wordpress-${WORDPRESS_VERSION}-ug_CN.tar.gz \
    && cp -rfv wordpress/wp-content/languages/* ${WORDPRESS_LANGUAGES_PATH} \
    && rm -rfv wordpress-${WORDPRESS_VERSION}-ug_CN.tar.gz \
    && rm -rfv wordpress 


COPY http.d /etc/nginx/http.d

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]