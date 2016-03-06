/*--------------------------------------------------------------*
 * AD.H - ad header description
 *--------------------------------------------------------------*
 * VERSION 0 - Original, first version with a version number
 * VERSION 1 - Added little indian field
 * VERSION 2 - Added div_per_sec field with respect to ad_rate
 *	       Chnaged ad_rate to an unsigned int.
 *--------------------------------------------------------------*
 * HISTORY
 * 27-Jan-89  Fil Alleva (faa) at Carnegie-Mellon University
 *	Added DEF_AD_RATE macro
 *
 *
 */

#ifndef _AD_H_
#define _AD_H_

struct ad_head {
    short ad_hdrsize;			/* Size of header, including this
				         * this field, in short words */
    short ad_version;
    short ad_channels;
    unsigned short ad_rate;		/* In quarter usec */
    int   ad_samples;
    int	  little_indian;		/* True if least significant byte is
					 * byte 0, ie. Vax byteorder */
    unsigned int div_per_sec;		/* How many divisions per second */
};

#define CURRENT_AD_VERSION	2

#define ADA_RANGE		(1<<16)
#define QUS_PER_MS		4000		/* Quarter usec / msec */
#define DEF_DIV_PER_SEC		4000000	/* Default value div_per_sec */
#define DEF_AD_RATE		250		/* Default value ad_rate */

#define SAMPS_PER_MS(r)		(QUS_PER_MS/(r))

typedef struct ad_head ad_head_t;

#endif _AD_H_
