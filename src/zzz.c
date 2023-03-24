#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

SEXP r_advance_state (SEXP sexp_e, SEXP sexp_c,
                      SEXP sexp_streamCg,SEXP sexp_streamBg,
                      SEXP sexp_streamIg,
                      SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
                      SEXP sexp_streamName);
SEXP r_create_current_stream (void);
SEXP r_create_stream (SEXP sexp_name);
SEXP r_get_current_stream(void);
SEXP r_randU01 (SEXP sexp_streamCg,SEXP sexp_streamBg,SEXP sexp_streamIg,
                SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
                SEXP sexp_streamName);
SEXP r_remove_current_stream (void);
SEXP r_reset_next_substream (SEXP sexp_streamCg,SEXP sexp_streamBg,
                             SEXP sexp_streamIg,
                             SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
                             SEXP sexp_streamName);
SEXP r_set_current_stream (SEXP sexp_streamCg,SEXP sexp_streamBg,
                           SEXP sexp_streamIg,
                           SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
                           SEXP sexp_streamName);
SEXP r_set_package_seed (SEXP sexp_seed);
SEXP r_set_stream_seed (SEXP sexp_seed, SEXP sexp_streamCg,SEXP sexp_streamBg,
                        SEXP sexp_streamIg,
                        SEXP sexp_streamAnti,SEXP sexp_streamIncPrec,
                        SEXP sexp_streamName);

static const R_CallMethodDef callMethods[] = {
	{"r_advance_state", (DL_FUNC) &r_advance_state, 8},
	{"r_create_current_stream", (DL_FUNC) &r_create_current_stream, 0},
	{"r_create_stream", (DL_FUNC) &r_create_stream, 1},
	{"r_get_current_stream", (DL_FUNC) &r_get_current_stream, 0},
	{"r_randU01", (DL_FUNC) &r_randU01, 6},
	{"r_remove_current_stream", (DL_FUNC) &r_remove_current_stream, 0},
	{"r_reset_next_substream", (DL_FUNC) &r_reset_next_substream, 6},
	{"r_set_current_stream", (DL_FUNC) &r_set_current_stream, 6},
	{"r_set_package_seed", (DL_FUNC) &r_set_package_seed, 1},
	{"r_set_stream_seed", (DL_FUNC) &r_set_stream_seed, 7},

	/* Finish R_CallMethodDef. */
	{NULL, NULL, 0}
};
/* End of the callMethods[]. */

void R_init_rlecuyer(DllInfo *info){
	R_registerRoutines(info, NULL, callMethods, NULL, NULL);
	R_useDynamicSymbols(info, TRUE);
} /* End of R_init_rlecuyer(). */
