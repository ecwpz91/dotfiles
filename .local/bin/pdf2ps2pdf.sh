pdf2ps2pdf() {
 # Convert all PDF files to PostScript in current directory
 for i in *; do [[ "${i##*.}" == "pdf" ]] && pdf2ps $i; done

 # Convert all PostScript files to PDF in current directory
 for i in *; do [[ "${i##*.}" == "ps" ]] && ps2pdf $i; done

 # Remove all PostScript files in current directory location
 for i in *; do [[ "${i##*.}" == "ps" ]] && rm -rf $i; done
}
