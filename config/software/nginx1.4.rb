name           "nginx1.4"
version        "1.4.1"

# nginx sources and md5
source          :url => "http://nginx.org/download/nginx-#{version}.tar.gz",
                :md5 => "fea7dfab995545ce27fe4c49dc21a972"

relative_path  "nginx-#{version}"

# nginx dependencies/components
dependency      "pcre"
dependency      "nginx-sticky"
dependency      "nginx-statsd"
dependency      "nginx-cache-purge"
dependency      "nginx-http-accounting"
dependency      "nginx-http-sysguard"
dependency      "nginx-tcp-proxy"


build do
  command ["./configure",
    "--conf-path=/etc/ngix/",
    "--prefix=#{install_dir}/embedded",
    "--with-ipv6",
    "--with-http_ssl_module",
    "--with-http_stub_status_module",
    "--with-debug",
    "--with-ld-opt=-L#{install_dir}/embedded/lib",
    "--add-module=../nginx-http-sysguard",
    "--add-module=../nginx-statsd",
    "--add-module=../nginx-sticky-1.1",
    "--add-module=../nginx-tcp-proxy",
    "--add-module=../nginx-cache-purge-2.1",
    "--add-module=../nginx-http-accounting",
    "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\""].join(" ")
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end
