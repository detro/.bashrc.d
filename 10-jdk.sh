if [[ "MACOSX" == ${OSNAME} ]]; then
	MACOS_JAVAHOME_BIN="/usr/libexec/java_home"

	DEFAULT_JAVA_HOME=$(${MACOS_JAVAHOME_BIN} 2>/dev/null)
	export JAVA_HOME="${DEFAULT_JAVA_HOME}"

	function jdkset() {
		local ver="${1}"

		# Unset `JAVA_HOME` before using the `java_home` command
		unset JAVA_HOME

		# Print a warning if the version requested wasn't found and it defaulted
		FOUND_JAVA_HOME=$(${MACOS_JAVAHOME_BIN} -v ${ver} 2>/dev/null)
		if [[ ${FOUND_JAVA_HOME} == ${DEFAULT_JAVA_HOME} ]]; then
			warn "Setting JDK: ${FOUND_JAVA_HOME} (default)"
		else
			info "Setting JDK: ${FOUND_JAVA_HOME}"
		fi

		export JAVA_HOME="${FOUND_JAVA_HOME}"
		nln

		jdkver
	}

	function jdkver() {
		info "JDK version:"
		java -version
		nln
	}
fi
