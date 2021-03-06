<#if package?has_content>
package ${package};

</#if>
<#list imports as import>
import ${import}.*;
</#list>

public class ${className} <#if implements?has_content>implements <#list implements as interface>${interface}<#if interface_has_next>, </#if></#list></#if>{

<#list fields as field>
<#list field.annotations as annotation>
    @${annotation}
</#list>
    private ${field.type} ${field.name}<#if field.defaultValue?has_content> = ${field.defaultValue}</#if>;
</#list>

    public ${className}() {
    }

<#if fields?has_content>
    public ${className}(<#list fields as field>${field.type} ${field.name}<#if field_has_next>, </#if></#list>) {
<#list fields as field>
        this.${field.name} = ${field.name};
</#list>
    }
</#if>

<#list fields as field>
    public ${field.type} get${field.name?cap_first}() {
        return ${field.name};
    }
    public void set${field.name?cap_first}(${field.type} ${field.name}) {
        this.${field.name} = ${field.name};
    }

</#list>
<#if equalsAndHashCode>
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        final ${className} that = (${className}) obj;
        return <#list fields as field>Objects.equals(${field.name}, that.${field.name})<#if field_has_next>
            && </#if></#list>;
    }

    @Override
    public int hashCode() {
<#if fields?has_content>
        return Objects.hash(<#list fields as field>${field.name}<#if field_has_next>, </#if></#list>);
<#else>
        return 0;
</#if>
    }
</#if>

<#if toString>
    @Override
    public String toString() {
        StringJoiner joiner = new StringJoiner(", ", "{ ", " }");
<#if fields?has_content>
<#list fields as field>
        if (${field.name} != null) {
<#if field.type == "String">
<#if toStringEscapeJson>
            joiner.add("${field.name}: \"" + com.kobylynskyi.graphql.codegen.model.graphql.GraphQLRequestSerializer.escapeJsonString(${field.name}) + "\"");
<#else>
            joiner.add("${field.name}: \"" + ${field.name} + "\"");
</#if>
<#else>
            joiner.add("${field.name}: " + ${field.name});
</#if>
        }
</#list>
</#if>
        return joiner.toString();
    }
</#if>

<#if builder>
    public static class Builder {

<#list fields as field>
        private ${field.type} ${field.name}<#if field.defaultValue?has_content> = ${field.defaultValue}</#if>;
</#list>

        public Builder() {
        }

<#list fields as field>
        public Builder set${field.name?cap_first}(${field.type} ${field.name}) {
            this.${field.name} = ${field.name};
            return this;
        }

</#list>

        public ${className} build() {
            return new ${className}(<#list fields as field>${field.name}<#if field_has_next>, </#if></#list>);
        }

    }
</#if>
}
