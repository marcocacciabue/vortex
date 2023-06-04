#' writeGenBank
#' Creates a bare bones gb format file. It is intended to be used for the SNPeff database creation
#' step. Do NOT use it to upload to ncbi.
#' @param x A list created with [create_gb_list()]. It has all the relevant information
#' to add to the genbank file.
#' @param file string. Name of the file to save. Default = out.gb.
#'
#' @return writes a genbank-like file
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#' x<-create_gb_list(sequence_stringset)
#' file_out<-paste0(x$name,".gb")
#' \dontrun{
#' writeGenBank(x,file_out)
#' }
writeGenBank <- function(x,
                         file="out.gb"){
  op <- options(useFancyQuotes = FALSE)
  on.exit(options(op))


  cat(paste0("LOCUS       ", x$name,"                ",x$size," bp",
             "    DNA     linear       ",x$date,"\n"), file = file, append = TRUE)

  cat(paste0("DEFINITION  .\n","ACCESSION\n","VERSION\n","KEYWORDS    .\n",
             "SOURCE      Unknown.\n"), file = file, append = TRUE)

  cat("  ORGANISM  Unknown.\n","            Unclassified.\n", file = file, append = TRUE)

  cat("FEATURES             Location/Qualifiers\n", file = file, append = TRUE)
  cat(paste0("     source          1..",x$size,"\n"), file = file, append = TRUE)
  cat(paste0("                     /organism=\"Foot-and-mouth disease virus - type A\"
                     /mol_type=\"genomic RNA\"
                     /strain=\"unknown\"
                     /serotype=\"unknown\"
                     /isolate=\"unknown\"
                     /db_xref=\"taxon:12111\"
                     /country=\"unknown\"\n"), file = file, append = TRUE)
  cat(paste0("     CDS             ",x$start,"..",x$end,"\n"),file=file,append=TRUE)
  cat(paste0("                     /codon_start=1
                     /product=\"polyprotein\"
                     /protein_id=\"unknown\"\n"), file = file, append = TRUE)

  writeSequenceAA(x, file)
  writeSequence(x, file)

  invisible()
}



#' find_ORF
#' Finds the ATG initiation codon in FMDV genomes.
#' @param x DNAstringset with the relevant sequence
#' @param start_codon Pattern string to search. Default ATG.
#'
#' @return the position of the relevant codon
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#' find_ORF(sequence_stringset)
#'
find_ORF<-function(x,
                   start_codon="ATG"){
  # TODO add check for fasta format
  Codon_positions <- Biostrings::start(Biostrings::vmatchPattern("ATG", x))[[1]]

  # TODO add loop for in case it those not detect a initiation codon
  Codon_positions<-Codon_positions[(Codon_positions>1000)&(Codon_positions<1100)]
  Codon_positions<-max(Codon_positions)
  if(length(Codon_positions)!=1){
    stop(paste0("Stopping because there were ",length(Codon_positions)," codons detected (allowed only 1)"))
  }
  return(Codon_positions)
}



#' find_STOP
#' Finds the first stop codon in FMDV genomes. It uses start_codon_position
#' to determine the correct translation frame.
#' @param x DNAstringset with the relevant sequence
#' @param start_codon_position numeric. Output from [find_ORF()].
#'
#' @return the position of the relevant codon
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#' find_STOP(sequence_stringset,
#'           start_codon_position=find_ORF(sequence_stringset))
find_STOP<-function(x,
                    start_codon_position){
  # TODO add check for fasta format
  stop_codons <- c("TAA", "TAG", "TGA")

  STOP<-vector()
  for(i in 1:length(stop_codons)){

    # search for pattern in sequence
    STOP_positions <- Biostrings::start(Biostrings::vmatchPattern(stop_codons[i], x))[[1]]
    # only keep those hits that are AFTER the informed firt codon
    STOP_positions<-STOP_positions[(STOP_positions>start_codon_position)]

    # check which of those hits are INFRAME
    inframe<-(STOP_positions-start_codon_position)%%3
    STOP_positions<-STOP_positions[inframe==0]
    # save to list only THE first one
    STOP[i]<-STOP_positions[1]
  }
  # sort vector in increasing order
  STOP<-base::sort(STOP)

  # keep only first and add 2 positions to include all the codon
  STOP<-STOP[1]+2
  if(length(STOP)!=1){
    stop(paste0("Stopping because there were ",length(STOP)," codons detected (allowed only 1)"))
  }
  return(STOP)
}

#' get_polyprotein
#'
#' A very simple wrapper around [Biostrings::translate]. Translate a DNA sequence
#' If no initiatio and/or stop codons positions are provided it uses [find_ORF()] and [find_STOP()].
#'
#' @param x DNAstringset with the relevant sequence
#' @param start_codon numeric. Position of initiation codon.
#' @param stop_codon numeric. Last position of stop codon.
#'
#' @return AA sequence
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#' get_polyprotein(sequence_stringset)
#'

get_polyprotein<-function(x,
                          start_codon=NULL,
                          stop_codon=NULL){

  if(is.null(start_codon)){
    start_codon<-find_ORF(x)
  }
  if(is.null(stop_codon)){
    stop_codon<-find_STOP(x,
                          start_codon_position = start_codon)
  }
  sequence<-Biostrings::subseq(x,start_codon,stop_codon)
  Biostrings::translate(sequence)

}


#' create_gb_list
#'
#' Creates a simple list containing all the necessary information for the [writeGenBank()] function.
#'
#' @param x DNAstringset with the relevant sequence
#'
#' @return A list
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#' create_gb_list(sequence_stringset)
create_gb_list<-function(x){
  out<-list()
  out$name<- names(x)
  out$start<- find_ORF(x)
  out$end<- find_STOP(x,
                      out$start)
  out$size<-BiocGenerics::width(x)

  out$date<-format(Sys.time(), "%d-%b-%Y")

  out$sequence<-  x[[1]]
  out$sequenceAA<-  get_polyprotein(x[[1]],
                                    out$start,
                                    out$end)
  return(out)
}

#' writeFeatureTable
#' Additional function to create Feature table. Useful for using table2asn.exe software, in case [writeGenBank()] doesn´t work.
#' @param x a list created with [create_gb_list()].
#' @param file string. Name of the file to save. Default = out.tbl.
#'
#' @return writes a feature table file
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#'
#' \dontrun{
#' writeFeatureTable(create_gb_list(sequence_stringset))
#' }
writeFeatureTable <- function(x, file="out.tbl"){
  op <- options(useFancyQuotes = FALSE)
  on.exit(options(op))


  cat(paste0(">Feature ", x$name,"\n"), file = file, append = TRUE)

  cat(paste0(x$start,"\t", x$end,"\t CDS\n"), file = file, append = TRUE)

  cat(paste0("\t \t \t product polyprotein\n"), file = file, append = TRUE)

  cat(paste0("\t \t \t protein_id	gb|ASM46745.1|"), file = file, append = TRUE)

  invisible()
}


#' writeSequence
#' write fasta sequence in genbank format.
#'
#' @param x a list created with [create_gb_list()].
#' @param file string. Name of the file to save. Default = out.gb.
#'
#' @return writes the sequence section of the genbank file
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#'
#' \dontrun{
#' writeSequence(create_gb_list(sequence_stringset))
#' }
writeSequence <- function (x, file = "out.gb") {
  if (length(seq <- x$sequence) > 0L) {
    seq<-XVector::toString(seq)
    lineno <- seq(from = 1, to = nchar(seq), by = 60)
    lines <- seq_along(lineno)
    n_lines <- length(lines)
    s <- character(n_lines)
    for (i in lines) {
      seqw <- ifelse(i <  n_lines, i*60, nchar(seq))
      seqs <- XVector::toString(XVector::subseq(seq, 1 + (i - 1)*60, seqw))
      s[i] <- gsub("[[:punct:]]", "", seqs)
    }
    s <- sprintf("%+9s %s", lineno, s)
    cat("ORIGIN", file = file, sep = "\n", append = TRUE)
    cat(s, file = file, sep = "\n", append = TRUE)
    cat("//", file = file, append = TRUE)
  } else {
    cat("\n//", file = file, append = TRUE)
  }

  invisible()
}
#' writeSequenceAA
#' write AA sequence in the genbank format, under the translation slot.
#' @param x a list created with [create_gb_list()].
#' @param file string. Name of the file to save. Default = out.gb.
#'
#' @return writes the translation section of the genbank file
#' @export
#'
#' @examples
#' file <- system.file("extdata", "SRR12664421_masked.fasta", package = "voRtex", mustWork = TRUE)
#' sequence_stringset <- Biostrings::readDNAStringSet(file)
#'  \dontrun{
#' writeSequenceAA(create_gb_list(sequence_stringset))
#' }
writeSequenceAA <- function (x, file = "out.gb") {
  if (length(seq <- x$sequenceAA) > 0L) {
    seq<-paste0("/translation=\"",XVector::toString(seq),"\"")
    lineno <- seq(from = 1, to = nchar(seq), by = 60)
    lines <- seq_along(lineno)
    n_lines <- length(lines)
    s <- character(n_lines)
    for (i in lines) {
      seqw <- ifelse(i <  n_lines, i*60, nchar(seq))
      seqs <- XVector::toString(XVector::subseq(seq, 1 + (i - 1)*60, seqw))
      # s[i] <- gsub("([/=\])|[[:punct:]]", "", seqs)
      s[i] <-  seqs

    }
    s <- sprintf("                     %s", s)
    cat(s, file = file, sep = "\n", append = TRUE)
  } else {
    cat("\n//", file = file, append = TRUE)
  }

  invisible()
}


