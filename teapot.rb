
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "3.0"

define_target "jpeg" do |target|
	target.depends :platform
	target.depends "Library/z"
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/jpeg" do
		source_files = target.package.path + "libjpeg-turbo"
		cache_prefix = environment[:build_prefix] / environment.checksum + "libjpeg"
		package_files = cache_prefix.list("build/libjpeg.a", "build/libturbojpeg.a")
		
		cmake source: source_files, install_prefix: cache_prefix, arguments: [
			"-DBUILD_SHARED_LIBS=OFF",
		], package_files: package_files
		
		append linkflags package_files
		append header_search_paths cache_prefix + "include"
	end
end

define_configuration 'test' do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
