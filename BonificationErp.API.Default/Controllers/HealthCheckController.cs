using Dharma.Common.Hosting.Controllers;
using Dharma.Common.Services.Shared;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using System;
using System.Net;

namespace BonificationErp.Controllers.v1
{
    [ApiVersion("1.0")]
    [Route("/v{version:apiVersion}/[controller]")]
    public class HealthCheckController: BaseController
    {
        public HealthCheckController()
        {

        }

        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest, Type = typeof(DharmaError))]
        [SwaggerResponse((int)HttpStatusCode.Conflict, Type = typeof(DharmaError))]
        [SwaggerResponse((int)HttpStatusCode.NotFound, Type = typeof(DharmaError))]
        [HttpPost]
        public ActionResult<string> Check()
        {
            string result = "UP";
            Console.WriteLine(result);
            return new ActionResult<string>(result);
        }
    }
}
