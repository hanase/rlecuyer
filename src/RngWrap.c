#include <R.h>
#include <Rdefines.h>
#include <R_ext/Random.h>
#include "RngStream.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static RngStream current_stream;
static double rn = 0.0;

void r_create_current_stream()
{
 current_stream = (RngStream) malloc (sizeof (struct RngStream_InfoState));

 if (current_stream == NULL) {
    error("r_create_current_stream: No more memory\n\n");
  }
 current_stream->name="";
  return;
}

void r_remove_current_stream()
{
  free(current_stream);
  /*    RngStream_DeleteStream(&current_stream);*/

  return;
}

SEXP r_create_stream (SEXP sexp_name)
{
  RngStream newstream;
  SEXP sexp_newstream;
  int i;

  const char *name = CHAR(STRING_ELT(sexp_name,0));
  newstream =  RngStream_CreateStream(name);

  PROTECT(sexp_newstream = allocVector(REALSXP, 20));

  for (i = 0; i < 6; ++i) {
    REAL(sexp_newstream)[i] = (double) newstream->Cg[i];
    REAL(sexp_newstream)[i+6] = (double) newstream->Bg[i];
    REAL(sexp_newstream)[i+12] = (double) newstream->Ig[i];
  }
  REAL(sexp_newstream)[18] = (int) newstream->Anti;
  REAL(sexp_newstream)[19] = (int) newstream->IncPrec;
  UNPROTECT(1);

  RngStream_DeleteStream(&newstream);
  return(sexp_newstream);
}

void r_set_package_seed(SEXP sexp_seed)
{
  int i;
  unsigned long seed[6];

  for (i = 0; i < 6; ++i) {
    seed[i]= (unsigned long) REAL(sexp_seed)[i];
  }
  RngStream_SetPackageSeed( (unsigned long *) seed);
  return;
}


SEXP r_set_stream_seed(SEXP sexp_seed, SEXP sexp_streamCg,SEXP sexp_streamBg,
		       SEXP sexp_streamIg,
		       SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
		       SEXP sexp_streamName)
{
  SEXP sexp_stream;
  RngStream stream;
  unsigned long seed[6];
  int i;
  const char *name;
  size_t len;

  stream = (RngStream) malloc (sizeof (struct RngStream_InfoState));
  if (stream == NULL) {
    error("r_set_stream_seed: No more memory\n\n");
  }
 
  for (i=0; i<6; i++) {
    stream->Cg[i] = REAL(sexp_streamCg)[i];
    stream->Bg[i] = REAL(sexp_streamBg)[i];
    stream->Ig[i] = REAL(sexp_streamIg)[i];
  }
  stream->Anti = INTEGER(sexp_streamAnti)[0];
  stream->IncPrec = INTEGER(sexp_streamIncPrec)[0];
  name = CHAR(STRING_ELT(sexp_streamName,0));
  len = strlen(name);
  stream->name = malloc(len+1);
  if (stream->name == NULL) {
      free(stream);
      error("r_set_stream_seed: No more memory\n\n");
    }
  strncpy(stream->name, name, len+1);

  for (i = 0; i < 6; ++i) {
    seed[i]= (unsigned long) REAL (sexp_seed)[i];
  }

  RngStream_SetSeed(stream, (unsigned long *) seed);
  PROTECT(sexp_stream = allocVector(REALSXP, 20));

  for (i = 0; i < 6; ++i) {
    REAL(sexp_stream)[i] = (double) stream->Cg[i];
    REAL(sexp_stream)[i+6] = (double) stream->Bg[i];
    REAL(sexp_stream)[i+12] = (double) stream->Ig[i];
  }
  REAL(sexp_stream)[18] = (int) stream->Anti;
  REAL(sexp_stream)[19] = (int) stream->IncPrec;
  UNPROTECT(1);

  free(stream);
  return sexp_stream;
}


SEXP r_randU01 (SEXP sexp_streamCg,SEXP sexp_streamBg,SEXP sexp_streamIg,
		SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
		SEXP sexp_streamName)
{
  SEXP sexp_result;
  RngStream stream;
  int i;
  double rn = 0.0;
  const char *name;
  size_t len;

  stream = (RngStream) malloc (sizeof (struct RngStream_InfoState));
  if (stream == NULL) {
    error("r_randU01: No more memory\n\n");
  }
 
  for (i=0; i<6; i++) {
    stream->Cg[i] = REAL(sexp_streamCg)[i];
    stream->Bg[i] = REAL(sexp_streamBg)[i];
    stream->Ig[i] = REAL(sexp_streamIg)[i];
  }
  stream->Anti = INTEGER(sexp_streamAnti)[0];
  stream->IncPrec = INTEGER(sexp_streamIncPrec)[0];
  name = CHAR(STRING_ELT(sexp_streamName,0));
  len = strlen(name);
  stream->name = malloc(len+1);
  if (stream->name == NULL) {
    free(stream);
    error("r_randU01: No more memory\n\n");
  }
  strncpy(stream->name, name, len+1);

  rn = RngStream_RandU01(stream);

  PROTECT(sexp_result = allocVector(REALSXP, 21));

  for (i = 0; i < 6; ++i) {
    REAL(sexp_result)[i] = (double) stream->Cg[i];
    REAL(sexp_result)[i+6] = (double) stream->Bg[i];
    REAL(sexp_result)[i+12] = (double) stream->Ig[i];
  }
  REAL(sexp_result)[18] = (int) stream->Anti;
  REAL(sexp_result)[19] = (int) stream->IncPrec;
  REAL(sexp_result)[20] = (double) rn;
  UNPROTECT(1);

  free(stream);
  return sexp_result;
}

SEXP r_reset_next_substream (SEXP sexp_streamCg,SEXP sexp_streamBg,
			     SEXP sexp_streamIg,
			     SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
			     SEXP sexp_streamName)
{
  SEXP sexp_stream;
  RngStream stream;
  int i;
  const char *name;
  size_t len;

  stream = (RngStream) malloc (sizeof (struct RngStream_InfoState));
  if (stream == NULL) {
    error("r_reset_next_substream: No more memory\n\n");
  }
 
  for (i=0; i<6; i++) {
    stream->Cg[i] = REAL(sexp_streamCg)[i];
    stream->Bg[i] = REAL(sexp_streamBg)[i];
    stream->Ig[i] = REAL(sexp_streamIg)[i];
  }
  stream->Anti = INTEGER(sexp_streamAnti)[0];
  stream->IncPrec = INTEGER(sexp_streamIncPrec)[0];
  name = CHAR(STRING_ELT(sexp_streamName,0));
  len = strlen(name);
  stream->name = malloc(len+1);
  if (stream->name == NULL) {
    free(stream);
    error("r_set_stream_seed: No more memory\n\n");
  }
  strncpy(stream->name, name, len+1);

  RngStream_ResetNextSubstream (stream);

  PROTECT(sexp_stream = allocVector(REALSXP, 20));

  for (i = 0; i < 6; ++i) {
    REAL(sexp_stream)[i] = (double) stream->Cg[i];
    REAL(sexp_stream)[i+6] = (double) stream->Bg[i];
    REAL(sexp_stream)[i+12] = (double) stream->Ig[i];
  }
  REAL(sexp_stream)[18] = (int) stream->Anti;
  REAL(sexp_stream)[19] = (int) stream->IncPrec;
  UNPROTECT(1);

  free(stream);
  return sexp_stream;
}

SEXP r_advance_state (SEXP sexp_e, SEXP sexp_c, 
		      SEXP sexp_streamCg,SEXP sexp_streamBg,
		      SEXP sexp_streamIg,
		      SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
		      SEXP sexp_streamName)
{
  SEXP sexp_stream;
  RngStream stream;
  int i;
  long e, c;
  const char *name;
  size_t len;

  stream = (RngStream) malloc (sizeof (struct RngStream_InfoState));
  if (stream == NULL) {
    error("r_advance_state: No more memory\n\n");
  }
 
  e = REAL(sexp_e)[0];
  c = REAL(sexp_c)[0];
  for (i=0; i<6; i++) {
    stream->Cg[i] = REAL(sexp_streamCg)[i];
    stream->Bg[i] = REAL(sexp_streamBg)[i];
    stream->Ig[i] = REAL(sexp_streamIg)[i];
  }
  stream->Anti = INTEGER(sexp_streamAnti)[0];
  stream->IncPrec = INTEGER(sexp_streamIncPrec)[0];
  name = CHAR(STRING_ELT(sexp_streamName,0));
  len = strlen(name);
  stream->name = malloc(len+1);
  if (stream->name == NULL) {
    free(stream);
    error("r_set_stream_seed: No more memory\n\n");
  }
  strncpy(stream->name, name, len+1);

  RngStream_AdvanceState (stream, e, c);

  PROTECT(sexp_stream = allocVector(REALSXP, 20));

  for (i = 0; i < 6; ++i) {
    REAL(sexp_stream)[i] = (double) stream->Cg[i];
    REAL(sexp_stream)[i+6] = (double) stream->Bg[i];
    REAL(sexp_stream)[i+12] = (double) stream->Ig[i];
  }
  REAL(sexp_stream)[18] = (int) stream->Anti;
  REAL(sexp_stream)[19] = (int) stream->IncPrec;
  UNPROTECT(1);

  free(stream);
  return sexp_stream;
}

void r_set_current_stream (SEXP sexp_streamCg,SEXP sexp_streamBg,
		       SEXP sexp_streamIg,
		       SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
		       SEXP sexp_streamName)
{
  int i;
  const char *name;
  size_t len;

  for (i=0; i<6; i++) {
    current_stream->Cg[i] = REAL(sexp_streamCg)[i];
    current_stream->Bg[i] = REAL(sexp_streamBg)[i];
    current_stream->Ig[i] = REAL(sexp_streamIg)[i];
  }

  current_stream->Anti = INTEGER(sexp_streamAnti)[0];
  current_stream->IncPrec = INTEGER(sexp_streamIncPrec)[0];

  name = CHAR(STRING_ELT(sexp_streamName,0));
  len = strlen(name);
  current_stream->name = malloc(len+1);
  if (current_stream->name == NULL) {
    free(current_stream);
    error("r_set_current_stream: No more memory\n\n");
  }
  strncpy(current_stream->name, name, len+1);

  return;
}

SEXP r_get_current_stream()
{
  SEXP sexp_stream,dummy,dummys;
  int i;

  PROTECT(dummy = allocVector(REALSXP, 20));
  for (i = 0; i < 6; ++i) {
    REAL(dummy)[i] = (double) current_stream->Cg[i];
    REAL(dummy)[i+6] = (double) current_stream->Bg[i];
    REAL(dummy)[i+12] = (double) current_stream->Ig[i];
  }
  REAL(dummy)[18] = (int) current_stream->Anti;
  REAL(dummy)[19] = (int) current_stream->IncPrec;
  UNPROTECT(1);

  PROTECT(dummys = allocVector(STRSXP, 1));
  SET_STRING_ELT(dummys,0, mkChar(current_stream->name));
  UNPROTECT(1);

  PROTECT(sexp_stream = allocVector(VECSXP, 2));
  SET_VECTOR_ELT(sexp_stream,0,dummy);
  SET_VECTOR_ELT(sexp_stream,1, dummys);
  UNPROTECT(1);
  return sexp_stream;
}

double *user_unif_rand ()
{
  if (!current_stream) {
    Rprintf("No stream created yet!");
    return NULL;
  }
  rn = RngStream_RandU01(current_stream);
  return &rn;
}
