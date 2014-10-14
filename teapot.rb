
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0"

define_target "jpeg" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "jpeg-9a")
		cache_prefix = Path.join(environment[:build_prefix], "jpeg-9a-#{environment.checksum}")
		package_file = Path.join(environment[:install_prefix], "lib/libjpeg.a")
		
		copy source: source_files, prefix: cache_prefix
		
		configure prefix: cache_prefix do
			run! "./configure",
				"--prefix=#{environment[:install_prefix]}",
				"--disable-dependency-tracking",
				"--enable-shared=no",
				"--enable-static=yes",
				*environment[:configure],
				chdir: cache_prefix
		end
		
		make prefix: cache_prefix, package_files: [package_file]
	end
	
	target.depends "Build/Files"
	target.depends "Build/Make"
	
	target.depends :platform
	
	target.provides "Library/jpeg" do
		append linkflags "-ljpeg"
	end
end
