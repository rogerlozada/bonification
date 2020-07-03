using BonificationErp.Application.Errors;
using Dharma.Common.Enums;
using Dharma.Common.Hosting;
using Dharma.Common.Pubsub.Extensions;
using Microsoft.Extensions.DependencyInjection;
using System.Diagnostics;

namespace BonificationErp.API.Default
{
    public class Startup : StartupBase
    {
        /// <summary>
        /// Construtor padrão.
        /// </summary>
        public Startup() : base(StartupEnum.API , typeof(BonificationErpErrors)) { }

        public override void BeforeConfigureServices(IServiceCollection services)
        {
            base.BeforeConfigureServices(services);
        }

        protected override string DefinePathBase()
        {
            if (!Debugger.IsAttached)
                return "/bonification-erp/api/default";

            return base.DefinePathBase();
        }
    }
}
