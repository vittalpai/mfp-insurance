/**
* Copyright 2016 IBM Corp.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
package com.sample;

import com.ibm.mfp.adapter.api.OAuthSecurity;
import com.ibm.mfp.server.registration.external.model.AuthenticatedUser;
import com.ibm.mfp.server.security.external.resource.AdapterSecurityContext;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.lang.String;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

@Path("/")
public class EmployeeResourceAdapterResource {

	@Context
	AdapterSecurityContext securityContext;


	@GET
	@Path("/publicData")
	@OAuthSecurity(enabled=false)
	public String getPublicData(){
		return "Hello, This is Public REST Endpoint and it works!!";
	}

	@GET
	@OAuthSecurity(scope = "employeeAccess")
	@Path("/basic")
	public String getBasicDetails(){
		return "Vittal R Pai\n28 years, Male\nBengaluru - 560072\nKarnataka State, INDIA";
	}

	@GET
	@Produces(MediaType.TEXT_PLAIN)
	@OAuthSecurity(scope = "accessRestricted")
	@Path("/compensation")
	public String getCompensation(){
		return "Your current compensation is $12,28,401 per annum";
	}
}
