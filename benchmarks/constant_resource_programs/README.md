This code are published in: 

```bibtex
@inproceedings{mantel_transforming_2015,
	address = {Cham},
	series = {Lecture {Notes} in {Computer} {Science}},
	title = {Transforming {Out} {Timing} {Leaks}, {More} or {Less}},
	isbn = {978-3-319-24174-6},
	doi = {10.1007/978-3-319-24174-6_23},
	abstract = {We experimentally evaluate program transformations for removing timing side-channel vulnerabilities wrt. security and overhead. Our study of four well-known transformations confirms that their performance overhead differs substantially. A novelty of our work is the empirical investigation of channel bandwidths, which clarifies that the transformations also differ wrt. how much security they add to a program. Interestingly, we observe such differences even between transformations that have been proven to establish timing-sensitive noninterference. Beyond clarification, our findings provide guidance for choosing a suitable transformation for removing timing side-channel vulnerabilities. Such guidance is needed because there is a trade-off between security and overhead, which makes choosing a suitable transformation non-trivial.},
	language = {en},
	booktitle = {Computer {Security} -- {ESORICS} 2015},
	publisher = {Springer International Publishing},
	author = {Mantel, Heiko and Starostin, Artem},
	editor = {Pernul, Günther and Y A Ryan, Peter and Weippl, Edgar},
	year = {2015},
	keywords = {Modexp, Program Transformation, Running Time Samples, Secret Input Values, Timing Side Channel},
	pages = {447--467},
	file = {Full Text PDF:/home/romi/Zotero/storage/FFC2CXYK/Mantel and Starostin - 2015 - Transforming Out Timing Leaks, More or Less.pdf:application/pdf},
}
```
and:
```bibtex

@inproceedings{winderix_compiler-assisted_2021,
	title = {Compiler-{Assisted} {Hardening} of {Embedded} {Software} {Against} {Interrupt} {Latency} {Side}-{Channel} {Attacks}},
	doi = {10.1109/EuroSP51992.2021.00050},
	abstract = {Recent controlled-channel attacks exploit timing differences in the rudimentary fetch-decode-execute logic of processors. These new attacks also pose a threat to software on embedded systems. Even when Trusted Execution Environments (TEEs) are used, interrupt latency attacks allow untrusted code to extract application secrets from a vulnerable enclave by scheduling interruption of the enclave. Constant-time programming is effective against these attacks but, as we explain in this paper, can come with some disadvantages regarding performance. To deal with this new threat, we propose a novel algorithm that hardens programs during compilation by aligning the execution time of corresponding instructions in secret-dependent branches. Our results show that, on a class of embedded systems with deterministic execution times, this approach eliminates interrupt latency side-channel leaks and mitigates limitations of constant-time programming. We have implemented our approach in the LLVM compiler infrastructure for the San-cus TEE, which extends the openMSP430 microcontroller, and we discuss applicability to other architectures. We make our implementation and benchmarks available for further research.},
	booktitle = {2021 {IEEE} {European} {Symposium} on {Security} and {Privacy} ({EuroS} {P})},
	author = {Winderix, Hans and Mühlberg, Jan Tobias and Piessens, Frank},
	month = sep,
	year = {2021},
	keywords = {Program processors, Prototypes, side-channel attacks, Side-channel attacks, Processor scheduling, Microcontrollers, Embedded systems, Codes, compiler hardening, controlled-channel attacks},
	pages = {667--682},
	file = {IEEE Xplore Full Text PDF:/home/romi/Zotero/storage/9KHHKHNA/Winderix et al. - 2021 - Compiler-Assisted Hardening of Embedded Software A.pdf:application/pdf},
}
```
