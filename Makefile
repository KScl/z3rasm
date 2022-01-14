default: all

ASAR=/usr/bin/asar

SOURCEDIR=inp
OUTPUTDIR=out

SOURCEROM=${SOURCEDIR}/z3.sfc
OUTPUTROM=${OUTPUTDIR}/baserom.sfc
OUTPUTPATCH=${OUTPUTDIR}/basepatch.bmbp

MAKEOUTDIR=@mkdir -p $(@D)

BASEASM=LTTP_RND_GeneralBugfixes.asm

$(OUTPUTROM): *.asm
	$(MAKEOUTDIR)
	cp $(SOURCEROM) $(OUTPUTROM)
	$(ASAR) $(BASEASM) $(OUTPUTROM)

$(OUTPUTPATCH): $(OUTPUTROM)
	@python3.8 patch.py

binary: $(OUTPUTROM)
patch: $(OUTPUTPATCH)

all: binary patch
