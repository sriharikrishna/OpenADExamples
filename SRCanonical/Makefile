# preprocess
func.pre.f90: func.f90
	${OPENADFORTTK_BASE}/tools/SourceProcessing/preProcess.py \
	--free -o $@ $<

clean: 
	rm func.pre.f90

.PHONY: clean
