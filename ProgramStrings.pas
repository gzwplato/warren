{
Copyright (C) 2012 João Marcelo S. Vaz

This file is part of Warren, a personal finance software.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

unit ProgramStrings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

const
  sCopyright = 'Copyright © 2012 João Marcelo S. Vaz';
  sHomepage  = 'http://github.com/jmsvaz/warren';

  sDefaultExt = '.wdb';


function GetLicenseFile: string;
function GetApplicationFullTitle: string;
function GetApplicationInfo: string;

function GetSaveDialogFilter: string;

resourcestring
  sAboutDialogCaption = 'About %s';
  sWelcomeDialogCaption = 'Welcome to %s';
  sOpenDialogCaption = 'Open existing file';
  sDatabaseDialogCaption = 'Create a new file';

  sDefaultFileDescription = 'Warren Database';
  sAllFilesDescription = 'All files';

  sProgramInfo  = '%s build for %s at %s with %s';
  sLicenseIntro = 'This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.';
  sAsIs         = 'This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.';


implementation

uses VersionInfo;

function MaskFromExt(Ext: string): string;
begin
  Result:= '*' + Ext;
end;

function FormatFileDescription(Mask,Description: string; LastFilter: Boolean = False): string;
begin
  Result:= Description + '(' + Mask + ')|*' + Mask;
  if not LastFilter then
    Result:= Result + '|';
end;

function GetLicenseFile: string;
begin
  Result:= ExtractFilePath(Application.ExeName) + 'license.txt';
end;

function GetApplicationFullTitle: string;
var
  PI: TProductInfo;
  ApplicationVersion: string;
begin
  PI:= TProductInfo.Create;
  try
    ApplicationVersion:= VersionInfo3ToStr(PI.FileVersion);
  finally
    PI.Free;
  end;
  Result:= Format('%s %s', [Application.Title, ApplicationVersion]);
end;

function GetApplicationInfo: string;
var
  PI: TProductInfo;
  ApplicationVersion: string;
  Target: string;
  BuildDate: string;
  CompiledWith: string;
begin

  PI:= TProductInfo.Create;
  try
    ApplicationVersion:= VersionInfo3ToStr(PI.FileVersion);
    Target:= PI.CPU + '-' + PI.OS + '-' + PI.WidgetSet;
    BuildDate:= DateToStr(PI.BuildDate);
    CompiledWith:= 'FPC v' + VersionInfo3ToStr(PI.FPCVersion)  + ' / LCL v' + VersionInfo3ToStr(pi.LCLVersion)
  finally
    PI.Free;
  end;
  Result:= Format(sProgramInfo,[Format('%s %s', [Application.Title, ApplicationVersion]),Target,BuildDate,CompiledWith])
end;

function GetSaveDialogFilter: string;
begin
  Result:= FormatFileDescription(MaskFromExt(sDefaultExt),sDefaultFileDescription);
  Result:= Result + FormatFileDescription(GetAllFilesMask,sAllFilesDescription,True);
end;

end.

