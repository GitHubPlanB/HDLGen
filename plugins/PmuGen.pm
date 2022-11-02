#!/usr/bin/env perl

##############################################################################################################
##############################################################################################################
##############################################################################################################
###                         Copyright 2022 Wilson Chen                                                     ###
###            Licensed under the Apache License, Version 2.0 (the "License");                             ###
###            You may not use this file except in compliance with the License.                            ###
###            You may obtain a copy of the License at                                                     ###
###                    http://www.apache.org/licenses/LICENSE-2.0                                          ###
###            Unless required by applicable law or agreed to in writing, software                         ###
###            distributed under the License is distributed on an "AS IS" BASIS,                           ###
###            WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                    ###
###            See the License for the specific language governing permissions and                         ###
###            limitations under the License.                                                              ###
##############################################################################################################
##############################################################################################################
##############################################################################################################

package PmuGen;
use strict;
use warnings FATAL => qw(all);

use Getopt::Long qw(GetOptions);
use Text::ParseWords qw(shellwords);

use eFuncPrint;

=head1 PmuGen

  &eFunc::PmuGen("");

  Optional Inputs:
    -clk clk_name    :  name of logic working on clock
    -output name     :  name suffix of output signals
    
    -arm  pwr_intf_style :  input clk soruce, from src0 to src7

    -en    en_ctrl   :  enable/disable ctrl signal name
    -test            :  generate test logic(OCC) if enabled

=cut

use base ("Exporter");
our @EXPORT = qw(PmuGen);

sub PmuGen {
    my $args = shift;
    @ARGV = shellwords($args);
    
    #================================
    # OPTIONS
    #================================
    my $clk     = "clk";
    my $osuffix = "suffix";
    my $arm_intf= "";
    
    my $en    = "";
    my $test  = 0;
    
    GetOptions (
               'clk=s'     => \$clk,
               'output=s'  => \$osuffix,
               'en=s'      => \$en,
               'test=s'    => \$test,
               'arm=s'     => \$arm_intf,
               )  or die "Unrecognized options @ARGV";
    
    #================================

    vprintl("\n//| =========================================================\n");
	vprintl("//| This function is still underconstruction, need more time\n");
	vprintl("//| any suggestion or solotion or contribution is really welcome!\n");
    vprintl("//| =========================================================\n\n");

    #================================
}

1;
