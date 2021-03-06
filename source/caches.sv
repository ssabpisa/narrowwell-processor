/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module caches (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  cache_control_if ccif
);
  // import types
  import cpu_types_pkg::word_t;

  parameter CPUID = 0;


  word_t instr;

  // icache
  icache #(16,CPUID) ICACHE(CLK,
    nRST,
    dcif, 
    ccif.iwait[CPUID], 
    ccif.iload[CPUID], 
    ccif.iREN[CPUID], 
    ccif.iaddr[CPUID]);
  
  // dcache
  dcache #(8,2,CPUID) DCACHE(CLK, 
     nRST, 
     dcif, 
     ccif.flushing[CPUID],
     ccif.dstore[CPUID],
     ccif.daddr[CPUID],
     ccif.ccsnoopaddr[CPUID],
     ccif.ccwrite[CPUID],
     ccif.cctrans[CPUID],
     ccif.ccwait[CPUID],
     ccif.dwait[CPUID],
     ccif.dWEN[CPUID],
     ccif.dREN[CPUID],
     ccif.ccinv[CPUID],
     ccif.dload[CPUID]
  );


/*  // // single cycle instr saver (for memory ops)
   always_ff @(posedge CLK)
   begin
     if (!nRST)
     begin
       instr <= '0;
     end
     else
     if (!ccif.iwait[CPUID])
     begin
       instr <= ccif.iload[CPUID];
     end
   end

  // // dcache invalidate before halt
   assign dcif.flushed = dcif.halt;

  // //single cycle
   assign dcif.ihit = (dcif.imemREN) ? ~ccif.iwait[CPUID] : 0;
   assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~ccif.dwait[CPUID] : 0;
   assign dcif.imemload = (ccif.iwait[CPUID]) ? instr : ccif.iload[CPUID];
   assign dcif.dmemload = ccif.dload[CPUID];

   assign ccif.iREN[CPUID] = dcif.imemREN;
   assign ccif.dREN[CPUID] = dcif.dmemREN;
   assign ccif.dWEN[CPUID] = dcif.dmemWEN;
   assign ccif.dstore[CPUID] = dcif.dmemstore;
   assign ccif.iaddr[CPUID] = dcif.imemaddr;
   assign ccif.daddr[CPUID] = dcif.dmemaddr;
*/
endmodule
